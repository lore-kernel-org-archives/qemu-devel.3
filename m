Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A061D1A639
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDos-0001NG-Qw; Fri, 09 Jan 2026 09:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDoq-0001My-VA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDof-0001nz-Kz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767970216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hKJYzXypoObHWE0+lZivItpHWdzI1zRTTPr8Z22OIs8=;
 b=WZ1VKpvLpYRDInRusZKNpkG4YSy0blFG7zuoBccpSfXH40JlTUt54QEphRSoyEtxnvd3ow
 hbb3o3c3LfBOgV1/mdp58KmpbuBI6ZdEHpLdCoPzALIPvyzhmjtrHcqUAVkrkC44XkS5ow
 smbaL/yQq3QZIDbfrFYj52khHC2ITe4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-1Y9dilvvM0iFY0WJG4ap_A-1; Fri, 09 Jan 2026 09:50:15 -0500
X-MC-Unique: 1Y9dilvvM0iFY0WJG4ap_A-1
X-Mimecast-MFC-AGG-ID: 1Y9dilvvM0iFY0WJG4ap_A_1767970213
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so29567035e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767970212; x=1768575012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hKJYzXypoObHWE0+lZivItpHWdzI1zRTTPr8Z22OIs8=;
 b=FTfL+66iNpAjcpR3+L0XV2nCC53xUpQ+ttmRDQDFinfvaa+J+tSVREY84DZFiECZIe
 jH0zZuJyQeu0cfnBECizcu7ry+gnsVHGACUYIxVB8Ow+U9IT1b6Oq3dklvgns5RBSAuB
 Iwh1pNotGJTuM5gSTK1oLjrzgNbc66UDHMNXfX7Ergw9qL2TQWSEOlyUvl7s8E5FtW/1
 xZEEM+WFsTgu6z3+nZ32S4TOx0arMhIc4r8yNgAOUmIO8fmlTYOaTG0kWr1NlnhlKoTw
 +UjYI3pYs70PWL4OG2MnMkxxZlbt+YbEI5G8sW1sEyplIb7sl8TAdqtWOGTMt58qjLZI
 ssuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767970212; x=1768575012;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKJYzXypoObHWE0+lZivItpHWdzI1zRTTPr8Z22OIs8=;
 b=J355pJpr1dbFU8lpxkQMrAuv94leIx5Qd98un7k8JXen52HzNLq+yV5Y1syuqT1t4d
 frJf3V+YK2LSpnuu9nlBr64TfhgNBl7g3HY1ibOpoaX0yLWAcSWZYscFwAA107It/rrg
 G3VgEeoKBcWChFh/UtP0UswSp7mql+g5hA/XxB2RyLOfTw5bH1/ID8uNIR9+CWqD4IRH
 vnQaxwtejp5ZZwoV6YB6otEgf1gH9GyyVs/nA7vmtYFDZD1U2yDG7FZzahYuI+rzl8Qw
 vCKGc8rQR1/LpvOyBNTEl0jHrKjd/zTuOC9zBlUbj4pGbbm+sOBBoOvnIzaRtzmLatng
 Ncgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMw0xFJUKrKxgQ7epR0Bd4rc+ofrE7u3RJUpaK44SWhzDpJj/5eQ33K6WPJRifcYUUcHe/ZtsNy7H2@nongnu.org
X-Gm-Message-State: AOJu0YxOSrEXZqY0eD7FqEBI/Y/PKrT/wmNFIow8C2xdMmMdD0vFEQp6
 dEFVHMAM48RCJB/CYnxLNB2byHwfJD/haoL1DvNYxV/hSp6iRc3giGY+odvCEHP1ttzKeHgwY0U
 DkdkCW4STwOnHOqOPzkvLsEbqSpUHF/sVct9kCUiwqD/ar6Cp7YbdD5KdkaFf6xsj
X-Gm-Gg: AY/fxX4HbL3KOD+UPlNFUzu61ywv5cVU2V07LydYI9bJYs1AGy25nh3p+8DvuR8lfTd
 XHjWFrdDNnTsJmpGAT+spbSgxteBQFn1prKyUtPix8e3ru3wgQoe7eJF3deAVS2t3XsJljYT6p0
 n8WuzBv1u5a8PbiU8UF/7K5PDrLOn1EqpNfDixrZSdsyoGN9OgqMZ6cHE7DUfgx/O2aO7Sgeogt
 cqrBB5yTbx1RfxcI0obRbcpHozAfUin3RfslV9IcWZC64BUACiyvUeI9ZBzVXreDGHnlxfZQMAB
 /+wQE7cTlkwzvEdT84OCZSByoJmwHJUDF34jY68PS75A9ycT7D8hjx2mhruB4SCTRirhUSETVEi
 R5Z77J/VydoQtRgbsScppLDGgHQDkqyOzJNGWs+8K74+ua02q
X-Received: by 2002:a05:600c:3152:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-47d84b1a04amr125171785e9.10.1767970212460; 
 Fri, 09 Jan 2026 06:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoqQXux82ZR4+a70F+mo6IDLiDlkf/cBcNGXpEq46pYJuQS3KFSwc90wEofKj90MLq8YjACQ==
X-Received: by 2002:a05:600c:3152:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-47d84b1a04amr125171415e9.10.1767970212039; 
 Fri, 09 Jan 2026 06:50:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8717a48asm65998385e9.8.2026.01.09.06.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:50:10 -0800 (PST)
Message-ID: <7dff37c3-0e7a-4f8f-a952-a4691ed01c4f@redhat.com>
Date: Fri, 9 Jan 2026 15:50:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/19] intel_iommu: Enable first stage translation for
 passthrough device
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
 <a080e728-6754-4897-9531-61b875720b33@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a080e728-6754-4897-9531-61b875720b33@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/9/26 15:34, Cédric Le Goater wrote:
> Michael,
> 
> Since there are a couple of VFIO series depending on this one, do you mind
> if it goes through the VFIO queue ?

For the moment, applied to vfio-next.

Thanks,

C.


