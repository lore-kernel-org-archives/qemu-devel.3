Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3B1C54F5C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp068-0007x2-Ks; Wed, 29 Jul 2026 04:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wp066-0007wT-Cw
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wp064-0002Dl-V3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785315423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MAmgpgxgKEF0Itqf2suRTbjpX6UGyLERA9meZ+jJ3Dw=;
 b=GdWUNgeH2jKUJ1P/IyECXhp/b3eegCMoMPKHmTLyVrzoCHrdRo4QjPcxw9xgU2qrKhfm9O
 EgudkyIvK6AUUkSBBS7bLGxFWYENz/QzEuA07/vct+dNyI+cCahwGEtqI73qVU6E9Vu26m
 7bqsJsrdOPK+eImKhD2EYjH0Z4d1sBk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-K3umwgMpMxaQmim5CzH5YA-1; Wed, 29 Jul 2026 04:57:01 -0400
X-MC-Unique: K3umwgMpMxaQmim5CzH5YA-1
X-Mimecast-MFC-AGG-ID: K3umwgMpMxaQmim5CzH5YA_1785315420
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so656417f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785315420; x=1785920220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MAmgpgxgKEF0Itqf2suRTbjpX6UGyLERA9meZ+jJ3Dw=;
 b=mp9muVPAJQO1OnQo+UYe8Jwmw9d0LPtXesFn7a1GTCt1SOCB57AHdHZhGdWZsEohrg
 8Uwd7u2Ydt84FuIOUvuRvbSZ3MPpPd4PngNBSHJ8b76u8/vZLQNG4qnzSDlcMyGrdmq8
 lm9xzwuXGE8tlBcMJIeRpk5QObPIkUI4DFKLyc5RQeipby5+5HVLAdYiEUrqF+R1jfhw
 sjzaPmb0PF1AMtpaN+iyTYCTaUntuidgc9rcT1hBoVwuc2vrTwrcxsyarlhu5A2QfnyZ
 UAKBMcuz9yaIoGI8h5JZGdUUI7ipG2X8UNsVOwjN5N491CI32h80NO/W1ngQ73ZULaJn
 hI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785315420; x=1785920220;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MAmgpgxgKEF0Itqf2suRTbjpX6UGyLERA9meZ+jJ3Dw=;
 b=TU1gHbji5KSz6DAjS7Egoe2+JCcGLBgPAT+v05XRiBM6TAB/suchHcqHHwm85w019T
 XV+wL1NGJnssKLkCAyoRVat78pbVBNkHCPKg9wKgao5oLFDFkoXkZKvZOjuCgVaw1IlA
 qBxSdnQrSHpvWTS/XUiViN6fNwZv9Vq2CnZZKQnJfkOaBbh2OGx4znJynz5rwiof3Ewu
 Idh4BO/Jt9B0qLivCKezc+u70+MXILAgf3htJ9AQ/dA0D9WV6z9qzrWqx5oZE1T2FecV
 AeZrg3HyqvrTtTJDivA8OtTI+qb2qvJdLWtX5cVrkSZ5/cWoCzJccp9r3rmGExfEADPw
 1ncQ==
X-Gm-Message-State: AOJu0YxxqympAoz3AeszClSOz/2vhviw1q1BHbgb9bMcWmMTtekoNKc4
 eLV56T6kSQs2YOaQzD7nGQt2MqHNrhb1nGemcnu+jjqjBidwKnxNB0VQKdUXroOlWZ0EHMxt4KZ
 69QE3BC74wgsVuWyuMmWLoQEVLzIUTUqlL/+g9hoGxc3H0qUJsHOeGz+i
X-Gm-Gg: AR+sD13/fTRSuE1tb5BMSqg8blAt79vWqaGIOx8+RjdvmWh9CCWxZ6B/s0W4ccVfU2Z
 IENBnWy7YweV1QAp9Bh9j6Fowta2FRbtOStMZZJ51uEpUXQ682W8CCcpfu5vJSoa4Rr1CWJ2v1A
 7ngQ63eBKO5ZjVPzqU6bVDwFtEdWTKmAFoihYhW6OX5Gyo3N2wb19Mp99hUYmlxzf/fPxMiRzDl
 BJ6avoHybPMgIJKlqwf0akxNntCqVPrJ+EqUqqeMTwj5Tf3x90SRVyemyBbnc6c89CJWSB6I6gW
 DYGbevB3VmVSxctL6tn8MO6xn29Z7SNwYe+WH0p+Q61dKXi39ePRRT1no/DzPaOhUdmW7V/MKsP
 Dfx7mq4G+UhlzR9THUxSl5RzYP+nbJG1R0VXzHRc=
X-Received: by 2002:a05:6000:25c8:b0:472:d154:fac6 with SMTP id
 ffacd0b85a97d-47fb1ecddbamr7411619f8f.35.1785315420432; 
 Wed, 29 Jul 2026 01:57:00 -0700 (PDT)
X-Received: by 2002:a05:6000:25c8:b0:472:d154:fac6 with SMTP id
 ffacd0b85a97d-47fb1ecddbamr7411603f8f.35.1785315420057; 
 Wed, 29 Jul 2026 01:57:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189f0sm5963280f8f.26.2026.07.29.01.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 01:56:58 -0700 (PDT)
Message-ID: <6a3b587a-09de-4d63-9aba-403a9af97b63@redhat.com>
Date: Wed, 29 Jul 2026 10:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Harden virtio migration load paths against crafted
 streams
To: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>
References: <20260710102859.1967551-1-lvivier@redhat.com>
 <20260725113324-mutt-send-email-mst@kernel.org> <amjEALq8-unXNAZS@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <amjEALq8-unXNAZS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/28/26 17:00, Kevin Wolf wrote:
> Am 25.07.2026 um 17:34 hat Michael S. Tsirkin geschrieben:
>> On Fri, Jul 10, 2026 at 12:28:56PM +0200, Laurent Vivier wrote:
>>> A crafted migration stream can crash the destination QEMU process
>>> through unvalidated fields in the virtio device state: an unbounded
>>> allocation in virtio-serial, reachable assertions in the shared
>>> virtqueue element deserializer, and assert()/exit(1) calls in
>>> virtio-scsi request loading.
>>>
>>> These are hardening fixes: the destination QEMU is in a paused
>>> pre-start state and the source VM is unaffected by a failed migration.
>>>
>>> Patch 1 validates the virtio-serial nr_active_ports count against the
>>> configured maximum before allocating the post-load array.
>>>
>>> Patch 2 replaces the assertions in qemu_get_virtqueue_element() with
>>> a bounds check returning NULL, and updates all callers (virtio-serial,
>>> virtio-blk, virtio-scsi, scsi-bus) to handle the failure gracefully.
>>>
>>> Patch 3 replaces the remaining assert() and exit(1) calls in
>>> virtio_scsi_load_request() with proper error returns.
>>>
>>> Tested with migration round-trips for virtio-serial (0 to 511 ports),
>>> virtio-blk (1-2 disks), and virtio-scsi (1-2 disks), plus the
>>> original PoC reproducers for issues #3801 and #3802.
>>>
>>> Laurent Vivier (3):
>>>    hw/char/virtio-serial-bus: validate nr_active_ports from migration
>>>      stream
>>>    hw/virtio: return NULL from qemu_get_virtqueue_element() on invalid
>>>      state
>>>    hw/scsi/virtio-scsi: harden virtio_scsi_load_request() against invalid
>>>      stream
>>
>> Kevin objected to my version of this, I guess same will apply?
> 
> Objecting is a big word. I suggested some improvements around passing
> errors to the caller instead of trying to handle everything locally. But
> yes, at the first sight I think they would apply here, too.

Michael,

will you rework your series or do you prefer I update mine?

Thanks,
Laurent


