Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF7AC55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 18:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqbJe-0003LF-Qi; Sun, 02 Aug 2026 14:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqbJT-0003KG-RB
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 14:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqbJS-0003r8-Ch
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 14:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785696808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYVCpnZYpqVihCP7e5RWd2hoz+wirO3wXs6KPu5jJS4=;
 b=i+H5EoznPx4seaipv4dWOGYdIZVr9mwyIsv78OJ075jXmt+WGxHEBcjYkToYr7hEtXnqHc
 BpVNvPNll/G6CljSGHq8lIwJB7K4wevTiHI3XjQZr7eMNqJ51iPLXf3F2Kp3efNGpOFTnR
 SYXBYqecaG+jj+iReIvFWvNkGOBoA/w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-o4J-JefoNcKRdtqTHcxe-Q-1; Sun, 02 Aug 2026 14:53:27 -0400
X-MC-Unique: o4J-JefoNcKRdtqTHcxe-Q-1
X-Mimecast-MFC-AGG-ID: o4J-JefoNcKRdtqTHcxe-Q_1785696806
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso8870775e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785696806; x=1786301606; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MYVCpnZYpqVihCP7e5RWd2hoz+wirO3wXs6KPu5jJS4=;
 b=RiKSXB0Oo/sQdppfwjdzn1TUC7uQav/1AZWy5d63erwOtcozO9OWxD26DdWvhyaxMj
 nZbqTevU7VgUFavNLPwWLMQQ6iz6ASNHx9WJkDStHS8KrrJrEj0XOD72J7NyaWYO/K/t
 fdOmZb8TW77kuluSJh1F/1YaXwyvwlrdkW9fdoBYmz/k2pfzAHAn6Xddo+ySYsY3cR8u
 AnLRK6ldZWW9XP7kJO/9sdC0m8mWX5U6rK5KbxLCugRhkERAFycebwAI9yr3eiQtfvMY
 T67nfEh0c++RgnuYKzhd3doPGDuKyNxLFzIah1sJhyn0pnhCQN3JaEGc4vhhdgUIF4Ea
 kpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785696806; x=1786301606;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MYVCpnZYpqVihCP7e5RWd2hoz+wirO3wXs6KPu5jJS4=;
 b=ANWywNQBIREVcUfzNZxzdnYqwzX9WlquKfHlpohd9G9xi9PQxzahTP/FQej1KtNLkw
 eaMSg9XU5KYyQMFa1pLGuC9meC+xLd7kl/oDQR6te9DngD9mejGOYccdIFlfVA5PkPIr
 3Xm7Nf+3k8RtWEJ26i8EiTTVptqkUuqn2ypuGv2GTCPGwKITw4w5+FpL6vnkb8vGtys1
 HemsV7tv1U4Bqr79U0JfE/XVvvA+QhxZpfBkwkjZlXTNr3FPOwEOZnxLf3JDb3Lvlbo6
 ujPwzDQvDHR3yn8d5+B9fA8YviygnGKEb2zi2P0mMkfHZMrHISNV7+uLHc4XLZ4YQr5Y
 TbGQ==
X-Gm-Message-State: AOJu0Yw3CnnMW9Nz9eWm6wycd7CQoAXMvN93opi3uxqk/b0lznQ+sNeP
 eF1/p6z0z26XL85Ike6dgOggQDSSY37265OCEg4oN/foF7gbaMjc4P0I8prJ0oupYE6c2WxUSNc
 Qe2mGQj58p7IFONzyOVaJAAC6XfDcqhzTg9hWyaiZol4ZUh+jGk5pnw3u
X-Gm-Gg: AR+sD117SDbl8UnvJV9kDJkkQ09TyjV2h1Q30hxoLX/AY/u2AWnp8VyieRgMKv8O0rA
 klMOYSNCtgT00abJZysxGBs4J1LxNyKPct2MSwW9Ygs4uM7JAPIFHH3OUCwSl1nCMIojPWHbR41
 FAgQ49jzvfuuwIzk5+5t/X9p+68IKtuR4W4PZ3iCZQuODmU/pCr9qOzRCv3vB9kXB9+jrpbQ53Q
 ehsdUqEvbklaLdDOcBZxqnJwJZ4aPz8eRzHlIIurSoB0/opqJRvVwaMXjrkVUNbcj+GYJTHkFpD
 PEtKh4FtWGNQNLl2wqJ5LUSe8z50pauG1VoPZeGxMQPwzR8D2a24BsVUnDdJ/HARxdZ9HyGZEMf
 WbbgpMKB+kas8K93YLTAURQ==
X-Received: by 2002:a05:600c:1504:b0:498:273:3271 with SMTP id
 5b1f17b1804b1-4980c66d9e0mr84516145e9.1.1785696806344; 
 Sun, 02 Aug 2026 11:53:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1504:b0:498:273:3271 with SMTP id
 5b1f17b1804b1-4980c66d9e0mr84515935e9.1.1785696805908; 
 Sun, 02 Aug 2026 11:53:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807bad893sm131614325e9.3.2026.08.02.11.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:53:25 -0700 (PDT)
Date: Sun, 2 Aug 2026 14:53:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Message-ID: <20260802145308-mutt-send-email-mst@kernel.org>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Sun, Aug 02, 2026 at 04:05:08PM +0000, Clément MATHIEU--DRIF wrote:
> SVM in Linux requires SMPWC as of 780dfed68862.

And what is 780dfed68862?

> This is free in the
> current implementation as it is already in line with the expected
> behaviour.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>  hw/i386/intel_iommu.c          | 3 ++-
>  hw/i386/intel_iommu_internal.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 8245452d89..9f21622a4f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
>      }
>  
>      if (s->svm) {
> -        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
> +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
> +                   VTD_ECAP_SMPWCS;
>      }
>  
>      vtd_reset_caches(s);
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 924e91cb8a..df7a0efa6e 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -202,6 +202,7 @@
>  #define VTD_ECAP_SMTS               (1ULL << 43)
>  #define VTD_ECAP_SSTS               (1ULL << 46)
>  #define VTD_ECAP_FSTS               (1ULL << 47)
> +#define VTD_ECAP_SMPWCS             (1ULL << 48)
>  
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */
> -- 
> 2.54.0


