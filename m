Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F895CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 15:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v69ma-0005LX-IS; Tue, 07 Oct 2025 11:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v69mY-0005LK-WF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 11:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v69mV-00048l-4Z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 11:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759851551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kz5GVGdZ8LlKD+G+4fk5oqBpla++fr1xnaewFUAS+qQ=;
 b=K7IhYOnLlBEQwmZuZ/bPxD681x7uOpJ+kfmwAZ96CEk3kz/IbruxKsYCsGDyICkdMAt2/P
 X0O+pcaF+BQa+AK2FOa7Oa8i2xgtoVE2gODmJxW6/lxVyPV2S59L3OSIB2nfYBI7pHHpQa
 TICmN4wOH8nrU73CTdKDceR7OaFpUVs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-WiTcX2hNOSKs8v0Yq2fQxQ-1; Tue, 07 Oct 2025 11:39:09 -0400
X-MC-Unique: WiTcX2hNOSKs8v0Yq2fQxQ-1
X-Mimecast-MFC-AGG-ID: WiTcX2hNOSKs8v0Yq2fQxQ_1759851549
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e32eb4798so36585605e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 08:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759851548; x=1760456348;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kz5GVGdZ8LlKD+G+4fk5oqBpla++fr1xnaewFUAS+qQ=;
 b=ZvP8hTbGDdcEKyiqoLWz0iplqYQDV2oc8ZffSD4zDMitXY/MN0IvMl6gu5FgskDW/t
 8sXq4l9f1luR5Zla+s0bOEX4CLVn1l3aKaren7MoAtYBjPc6hvGMlMAuVulOkQDGQSPo
 0t3Q2cBS4yLBSuaqscVTQ8Nj+XpPql0fccL7Ii/5+seYYQt692bTZgnRojCJyApVHJVV
 /zqXQfYr64pCR6M72aSQ3Jy9sjmTkUhUEqHD3GKANkQMJJLa81rwiEs2UbdRaKw23boc
 OFbLNVKBWZyAfEaUHTcbB6ThMKmeH2RFuM9tcX3fFVN40zNnSaDAh7B3gKoBtko2EzSw
 tQyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJQJ4RELRCfVUrN8HDlef4QsUNEv9OjqIJ26YH30vUF5ULQaq52CPB5vwihuQaDZznKbc7InaDbORa@nongnu.org
X-Gm-Message-State: AOJu0YyNUVNoKDpzIK5Q88RYpghC+5v+OngLNvJsXPcggewLzD8X3bNI
 pRUIpSWXLNVYPF4sE3zuVoa/skpX4VEbTpuT0x6G7mmAVJP9klsCuX73f2qJ8bxERmodED62E3y
 bf2L4LaLvsEkNTZMqUvIxRjoK29ReGrtUPs3JNsQS39Rnw+9utt/rpEcl
X-Gm-Gg: ASbGncv6Rn1sSjTndsRuxB7VFKCnoAAiQUjo3k+vB5zI5e1C/qGYwgjmD9cFfyY+KPf
 MRjzUCXFkKA+Iyf8Wz2DIDZMYaqDZKQ5tov6IlsfX0MyG2ACegx9eAvH+XNKUxEdDJ3qke5/A2i
 M60FrE2ZGT2BBXu7I8VLdFjdoc3wfrLi1IqaKEWPRDLyKGWOzYKn4FwlLGqpeW4LoRMveK7w/fs
 ePZK/6Ts3/Qj9/iONK8pHxSfNZq0OZCCKwWYHMqP8KyUBAnWkETEe6UEo8mb+4Lxh4RRnETSaqC
 55IYnjpaz6XLQkx01lGiiA42Z1UGDakGw64rEi0/Iu9fCtHmVbcbKgnorCfTVAvea1O2Ri8TlSy
 Zf976PdEr
X-Received: by 2002:a05:600c:1f84:b0:46e:4cd3:7d54 with SMTP id
 5b1f17b1804b1-46fa9aef45fmr368245e9.18.1759851548606; 
 Tue, 07 Oct 2025 08:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjmj8Nob0DBlwAz0qpipmVL/PrmzN8h+F/vq4nYTq8Ha0yOAl1lF66zmIkPH6OehwbX2+/dA==
X-Received: by 2002:a05:600c:1f84:b0:46e:4cd3:7d54 with SMTP id
 5b1f17b1804b1-46fa9aef45fmr367975e9.18.1759851548051; 
 Tue, 07 Oct 2025 08:39:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e5fdsm212597595e9.6.2025.10.07.08.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 08:39:07 -0700 (PDT)
Message-ID: <c8e8d9a7-7973-417e-96b4-02e50150323d@redhat.com>
Date: Tue, 7 Oct 2025 17:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] VFIO: cpr-transfer fixes
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250928085432.40107-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/28/25 10:54, Zhenzhong Duan wrote:
> Hi,
> 
> Patch1: fixed an error restore path when virtio-mem is configured.
> Patch2: fixed assert failure on error restore path, this issue happens
> no matter if virtio-mem is configured.
> Some trick is played to trigger the error path,
> see https://github.com/yiliu1765/qemu/commit/494d19e7f7242dbc47d7f236937cde0c396a4a7c
> 
> Patch3-4: issue only happens with two or more VFIO devices, no issue
> if only one VFIO device.
> 
> Patch5: fix a bug that impact "query-balloon" execution
> 
> Patch6: SIGSEGV if I send "query-balloon" to source qmp monitor,
> I'm not quite sure if it's deserved to be fixed, as guest has been
> migrated to destination, it's not a big issue for source qemu to
> SIGSEGV?
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v2:
> - minor polishment to commit log (Steve)
> - keep kvm_state so "query-balloon" could work after CPR-transfer (Markus)
> - add a fix which is found during "query-balloon" execution
> - rebased to master
> 
> Zhenzhong Duan (6):
>    vfio/container: Remap only populated parts in a section
>    vfio/cpr-legacy: drop an erroneous assert
>    vfio/iommufd: Set cpr.ioas_id on source side for CPR transfer
>    vfio/iommufd: Restore vbasedev's reference to hwpt after CPR transfer
>    accel/kvm: Fix an erroneous check on coalesced_mmio_ring
>    accel/kvm: Fix SIGSEGV when execute "query-balloon" after CPR transfer
> 
>   include/hw/vfio/vfio-cpr.h |  2 +-
>   accel/kvm/kvm-all.c        | 14 ++++++--------
>   hw/vfio/cpr-legacy.c       | 22 +++++++++++++++-------
>   hw/vfio/iommufd.c          |  8 ++++----
>   hw/vfio/listener.c         |  4 ++--
>   5 files changed, 28 insertions(+), 22 deletions(-)
> 


Applied patches 1-5 to vfio-next.

Thanks,

C.



