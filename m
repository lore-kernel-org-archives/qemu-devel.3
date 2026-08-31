Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DACC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x10dG-0004Nh-Um; Mon, 31 Aug 2026 07:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x10dF-0004NO-La
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x10dD-0000vJ-R7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788177413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Eyly2t/vqqTukrVYOmINAGrYGwBygQha82+CC7HjkEI=;
 b=bVh2A6jIWbUJYo/DUOxMaA5Du/Ype+CAgN5yTd9S685eCBR7ljb3EeRm6IrIJkmchftXzu
 rxv5gzUppaaXCLWZ2znxLPveITk5YTLIKJdxEf8nvDKo4+FvpPjoFSFgM+azE9+MDSkxnW
 /D27DMSPDceK03uJn1rfkewcEiDLztg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-uTPd6i4sPg-RlX8d6SymiA-1; Mon, 31 Aug 2026 07:56:52 -0400
X-MC-Unique: uTPd6i4sPg-RlX8d6SymiA-1
X-Mimecast-MFC-AGG-ID: uTPd6i4sPg-RlX8d6SymiA_1788177411
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so23786995e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788177411; x=1788782211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Eyly2t/vqqTukrVYOmINAGrYGwBygQha82+CC7HjkEI=;
 b=huIHtLXcu8MRCU8K+QxRe7tYzqi2EkSXHUBmMrsGf2CLAmOJ6TGMaYErG7UxD1ofOs
 x7Djf2SyRSPzSg9SI3q+73CSD9gH7c2OJfAJ9lR/7QusTjV37Xxs536TMA5jE3RlzXGY
 BaA44mcN5q7ZpMgFfu6zVbsWDjdbfx+rRpVzjNTzWSA41Bxb3/xwVoANV2NyS6sUqQkk
 sROiUCybJlzyZ4oQO504cGGKGh7wD/HZfF2hfRKOpBeKmwkD6pdbBeQd73Pt4Nm4c57b
 otzvxK8D160S6YLgltVIlPgaj3FWZkpF5v6BXxegFlDvD/0ZQ8Br6R7UWVTeA4VCNcDv
 0K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788177411; x=1788782211;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Eyly2t/vqqTukrVYOmINAGrYGwBygQha82+CC7HjkEI=;
 b=RiufwxiYB/ydk3l8BOuREK8aWLeSt/blxEiZIxFr60K23/g9ZFOfFVwz322natbdKl
 c+uf6bK+IZt13ch/wzGUbuzmZBoQXJIw9H27PgjMqgngIz28ewNsryA2G5A8u0xj2Mfj
 N8Kf17hdb9q6SXhCVBDOL/M2FDda7uQii/tGlwETutXlmtJ2CUj19rzkdfgmFJ1GRXxq
 0FWxg3qO8qIpT1/t9jgWJaGW1U6EGz+yEGO7DhdJBu6kN3T4wltrVko859FpboAJQdhI
 itEhwXGsvjOSBmBugfOgzJhgCKPSC4zKYrz///T8+ZTviYMYarUeZuAX+VHHjzxy7O/y
 wnVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqeWsxAcyNfPC6ugXVWYsNmDNZDRmNHu0hUHaGCyb7vCjfb0jYtWdZdvlHDXuvjp+1dzbWL1K+M1Zbu@nongnu.org
X-Gm-Message-State: AFuF++k8c0jHgMYaeCEKkUdYj0ukLjL08UsN761NhWVPtyKMqwQAIAuN
 gJjVwbcxLYwWgtLKv5v1dHlMzxElWSQfJ/Z4QtRDOp/pO9WI3gmsUIzvn4BsZo3uPNo4RElXyuU
 jlvU8dXF3ZSKJCX/ySZioP4cIiXlH02Oc+tfrhvwO7ovx+NNKSoZXyi1D
X-Gm-Gg: AR+sD13Olq1erxw/uu66pc/o1p4QO+aSZKV/yBxtez7YtLau+FNyaP1rJgmdjXsuz5X
 QYG6u7Nz2cTiO611BaF9Fp9dprcspSXC+KPbV6gxnbYS+pGAUOxDlza3kscmC7qQgA/JfXWVaZd
 pvHW/JPD/P58o+n9TGFunqQNR/CUQ7MKGsGkuOt1YDJ6SC944fh+Z98TtB41HxF4Qit6YqExk/d
 B29YTh2DAdRW0aCIyqZQB0+mrqdrcTB9EDc3Ot75706EHU6Onqi+DbCyi4PCf8FRWt0XgeXLsa/
 rXIJ65aG1CBnOnui+wFc2+/c4pxEZ+xfl3Wpwxdi93B8bdQJ0FmyzPn09wvutbRzTVwjZbRVag8
 nEtCE7iVK6y8QLFlyqxgahBvRIMdEFMOPcA1KZXk=
X-Received: by 2002:a05:600c:a106:b0:49c:cb6a:1687 with SMTP id
 5b1f17b1804b1-49ccb6a1689mr227321095e9.4.1788177410928; 
 Mon, 31 Aug 2026 04:56:50 -0700 (PDT)
X-Received: by 2002:a05:600c:a106:b0:49c:cb6a:1687 with SMTP id
 5b1f17b1804b1-49ccb6a1689mr227320425e9.4.1788177410469; 
 Mon, 31 Aug 2026 04:56:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccf59324esm183180235e9.5.2026.08.31.04.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 04:56:49 -0700 (PDT)
Message-ID: <b8cc9490-6716-4eb9-b330-728ebe87ae99@redhat.com>
Date: Mon, 31 Aug 2026 13:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add self as sPAPR EEH reviewer under
 PPC RAS
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, sourabhjain@linux.ibm.com,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 hbathini@linux.ibm.com, shivangu@linux.ibm.com
References: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
 <20260831071958.58824-7-nnmlinux@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260831071958.58824-7-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/31/26 09:19, Narayana Murty N wrote:
> Adding self as reviewer for the sPAPR EEH under PPC RAS.
> Updating the EEH specific file name as got updated in previous patches.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a49a40294..9271d849b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1770,11 +1770,12 @@ M: Aditya Gupta <adityag@linux.ibm.com>
>   R: Sourabh Jain <sourabhjain@linux.ibm.com>
>   R: Hari Bathini <hbathini@linux.ibm.com>
>   R: Shivang Upadhyay <shivangu@linux.ibm.com>
> +R: Narayana Murty N <nnmlinux@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Maintained
>   F: hw/ppc/spapr_events.c
>   F: hw/ppc/spapr_fadump.c
> -F: hw/ppc/spapr_pci_vfio.c

Nothing is left in hw/ppc/spapr_pci_vfio.c ?

> +F: hw/ppc/spapr_eeh.c
>   F: hw/ppc/spapr_rtas.c
>   F: hw/ppc/pnv_mpipl.c
>   F: include/hw/ppc/spapr_fadump.h


