Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4364F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ich-0005lY-Om; Mon, 23 Mar 2026 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ice-0005ku-AH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4icc-0001Ly-Fo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774285161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5AE0znWhenyTNa+WWq526x8WtaLZytj+XORB/oooaE=;
 b=KXwKCgtvJCJIprdJohJxED+7lZaMHVj39fwSnmVo5B+3EuR3nZIMmACn9cObbjcoVIHfJ5
 xuLSZXYxVPdVIZ/JxYetKCv4AmB/2vDJ/KejEu8xBFNyynV2w/sDQeYEgX7XuolCU6JXtN
 11eoGbP+ZPWeOUngHFWO/DG2/Olxkq8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-0QvPeIjLM0G1eHT1HL_yXg-1; Mon, 23 Mar 2026 12:59:20 -0400
X-MC-Unique: 0QvPeIjLM0G1eHT1HL_yXg-1
X-Mimecast-MFC-AGG-ID: 0QvPeIjLM0G1eHT1HL_yXg_1774285159
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48553fdd03dso3994615e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774285159; x=1774889959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W5AE0znWhenyTNa+WWq526x8WtaLZytj+XORB/oooaE=;
 b=N5FoQWaaQ1TFetJtcPVjSFgFhH8DHayscqjXW9iqmWqkvXNANXU6a27xMXoQdb629q
 YlI1a/NhHtYf7eoGR8gyti5mNgpGUifh4MZfbKgSS0ScmH6sriM8qe10ftRuD5kgJmDA
 RUf+EUufmfTxcEYbfGtLaOTHKw+MpXk6zYPGZa3sm4r7UqWZMvHMhiFftxOa7t+r6Ztq
 bYXeprrqoFsy0c5SE3lhL2TqrO4eFBUvetvAkrpfYRur+AD3Q8FnKxWnkCYo153TK9z0
 9e5vCnCUrk+o1tN7/HpwV6BCOd/csPO0b6zQ2U9Pys7DbPw+R77tEg26d2q3aY6B3vqp
 DzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285159; x=1774889959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W5AE0znWhenyTNa+WWq526x8WtaLZytj+XORB/oooaE=;
 b=l4wX+kQ+3DWig2Qas6OzNFOxodbZVMZj5wyxolmozYCkxBSDr8L0yWrrha7DFLKAaR
 RclfMaEIQkjPOHNT/GcLaz2eZYzZjKrf5st//5jtfcbX4OM+jVUqztJ0FMcNQI81xhTS
 QgDQsYp92hGzToNMpXhL6DegDDjJlWpaNinauen8MO9h1nNwJFKJ0yYsl1RLFfAy+yOf
 5fmTssxOEnGa7dFeN//CY0PTlRmwUGtfQ3aEKQtLhf2Ro6e2RuKLauWI1gMsnOcUu5Ba
 SgzseleWig9zDqCWnuP669RmUe69pUanQcyxI/E747ilkg7dnomb7K/Ii0LFMCxk4bvF
 gPZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeG9qDHUFXAal12BFHpOHkJNso0gAlIm1Eor9WMOLe7G38Q5Fvly+QKVZWQgKncffyG0Sz53torkCx@nongnu.org
X-Gm-Message-State: AOJu0Yxj6E2j4BfQ82vl4Of6SW5r+Ujicnnz3J05PDAKpl5dmDVCn7sL
 hszOL47gAPKrW5Mhz3+RlOPoZRu4kS85eUyPlPz/h05xKedMdqveVq0K1LR2dvM7Ie74H+BCEKh
 PqA85bqvCBLHi+nvyDu5aB28LKqOQvUj4+0vPNu3NWhU9cBj7rZ7F9Tsq
X-Gm-Gg: ATEYQzz0sAlUCg76xo6BJ1MwLQsCcFhHznhU7Q2vq7vTxRw0s6Psg/60G0Td8cNVrkt
 B2EXI75nZco3Q+pIfZ0figoJFre4FY5RirHT8sUKgsGmOmV/mWVUrpWbKudy7v4J+UfmniCBp7T
 CuKkdeeCCFrV4zKrJ88JIih+R5XWIFSE0w1g4dR+PPPJz+Sv8c5pkEF9RCnj9TH9oURKgTRPySj
 3UVDd3gR08CBQw+4N+dIWOE9VnpqCS7DfPmVCXuFPJsduN/5fvklAzvHgHsmPXKUaG1iyJoGFXV
 HQGDbfyqdaAoFFh4jXPpvrQy/wtbxLxmGQee5VUV3HhdKJ68ju3ZJQlRNv6BtnAIs0KrlZoVerF
 SFUmQsbtBDjmVr6WZsnTswJX6rJPA+dRa4h7+An1dix8txbBkCEWRgRAQCh7jbYw4bZk39IjrLV
 Jm3fbIcGWmJ25x+h2xiOVr8U+NbFqhSRvySDgR1bvDhoeoF1yO8SY=
X-Received: by 2002:a05:600c:34d5:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-486fede7225mr168867535e9.6.1774285158931; 
 Mon, 23 Mar 2026 09:59:18 -0700 (PDT)
X-Received: by 2002:a05:600c:34d5:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-486fede7225mr168867155e9.6.1774285158513; 
 Mon, 23 Mar 2026 09:59:18 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d03c:df99:cbc9:b444:8cfa?
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe032a55sm563055095e9.7.2026.03.23.09.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 09:59:17 -0700 (PDT)
Message-ID: <bc1f675d-42c3-47d5-98de-2696a352b92b@redhat.com>
Date: Mon, 23 Mar 2026 17:59:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 0/3] linux-aio/io-uring: Resubmit tails of short
 requests
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
 <acFlG40EEYrKkJWq@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <acFlG40EEYrKkJWq@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23.03.26 17:28, Kevin Wolf wrote:
> Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
>> Hi,
>>
>> Short reads and writes can happen.  One way to reproduce them is via
>> FUSE export, if you force it to limit the request length in the
>> read/write path (patch in the commit messages of patches 2 and 3), but
>> specifically short writes apparently can also happen with NFS.
>>
>> For the file-posix block driver, aio=threads already takes care of them.
>> aio=native does not, at all, and aio=io_uring only handles short reads,
>> but not writes.  This series has both aio=native and aio=io_uring handle
>> both short reads and writes.  zone-append is not touched, as I don’t
>> believe resubmitting the tail (if a short append can even happen) is
>> safe.
> Originally, I think you had intended to loop in coroutine code. Now it
> looks like you decided to resubmit already on the lower level directly
> when processing completions. Obviously, both approaches work, but I'm
> curious what are the reasons that made you pick this approach after all.

io-uring did it this way, so I thought for a series for the freeze 
period, it would be safest to just copy what it does.

Hanna


