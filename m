Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46915C5AD4D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 18:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtV7y-0002dn-DK; Fri, 20 Feb 2026 13:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtV7x-0002df-73
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:21:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtV7v-0001v3-3L
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771611675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qx3KqccoVD+buOQJFSsol/WxOhpIJq+dUsmxkc+v/TM=;
 b=TJDhjN0WCxOeU+ppEcvgc8OvKIJXn2XcioKd9vxti2H0lEeAn+GqFyszhQXH1VQ0ZVWXnR
 Do6n8Eug4GffuILVHiMg9/2rgqKOBOHGQhoISuBRFUKHF+2oVuPxRo1cN51to3ug3bUjqr
 PGN5fhz+zpwOq0zi/BBJit+JxPKpFoc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-mr93H8lNMz-HfKMVjecr9Q-1; Fri, 20 Feb 2026 13:21:14 -0500
X-MC-Unique: mr93H8lNMz-HfKMVjecr9Q-1
X-Mimecast-MFC-AGG-ID: mr93H8lNMz-HfKMVjecr9Q_1771611673
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43768240a29so1776083f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771611673; x=1772216473; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qx3KqccoVD+buOQJFSsol/WxOhpIJq+dUsmxkc+v/TM=;
 b=JI7hmmQaNwy4mjLCEie3qoQJLFL0SfwEtQRDWmLtr8cBBeXBx/9LkoINzgYXHZzpPx
 rslVKypBL9otuZyB1v/VKTMEotOHpo7oYPE/9znmcRmDTrHx+9rIwjIM68UsFM8fqiBS
 s5YqsmwlyXOGlIac2RoJm4Ty07uHegVJztHvHOxv4WzcPUIKjsQZ9Rquygxaz9UHfFi8
 HLVu8rHetWnsxrtOrjsz8HYGLdSEx+Jt9BQ738bVDRQjsbOkochKohSZxNTKL13mybvn
 XpDHHb1g9uCpquxQNvhV1EDalHilaid80QaGbLs/VeXJKghSB0zlMw0Vhy5akEyzjEaN
 EZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771611673; x=1772216473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qx3KqccoVD+buOQJFSsol/WxOhpIJq+dUsmxkc+v/TM=;
 b=eXWShDhJ8e102/ovenn5udDyd9pLC66IzEarnTf8uKd18c9jTIjZjEiW1SNL/F/Hbr
 WR+EY5c+nP9G8L9zSKuOeEZZ3mDQBJinD8981ePXql7AvuqS4gbXH4kl0TbQD4U1/6Fv
 BeNmO4cvhbALMpK9SdI97RTdrnbZF//uo25ZtGJzpLkvRezv+NIneG/MFk3flASad4Cz
 xCfY6R1o7WjqsWp97jZcXUWupoaP2eQAJKIL/V5Zf41evGwFstMqxj1GuS4azHfzGc9S
 lQFlKGI0xH/y1qTms++8Ub3X+gkN3LPMSP93sciR5L02kzt43bdZFnjwYijCgTJPq3ob
 9pqg==
X-Gm-Message-State: AOJu0Ywu/FsiNxAXBzX4aiBG+KoAZm3ZuvHTdVxe7a91UV57DGtqnb9q
 kHVbtf4foFaHKfs7qdPwB52baYZkfEaaYTVGdxSnUU4b7UpFedPOQ5Y2G+jTGhZ++G/HXcANCF0
 btsagvCdwpERjuMbLiVCrJmdayr86BQVTLII5RcT0Wx/yqb1DwZYbqNbv
X-Gm-Gg: AZuq6aLGaj7PCysCSETIaY/cfGJL1oXS4ywY/n3geEuN4ZyQ9WHEndHEEWjbiX66ym4
 vUbq0inPw+rsbHtFYeLvNNqO1B4CKbOSohh0IQuyXC/5CftxHCGDEX++9LbBvOviN5wLxxASsRi
 glF3T8LsSoNLANKXyaPd4bsL2mnjgXHqSIyAU847T1l5x2QdpcH7zUzp0VZGvRoTXvD2GrOQ1/2
 I4JO+X+WtH3ihMANoheTjCCJywQe1K16CNRhead3jt/Ik1Ah2e044gfj1UjFt5v0soqRs/5q0ne
 I9dmdpKKqK5F3zrSLWNdSHrqO2eYVEAB8eQkRxsTT9DPWaLB4Ur0S3bRuyCJdjmcEZoia34QCIO
 gVurlw8syg1OpwgjM/pP5oSd8ZGTCtj2O1siSF4XJc+FngQ==
X-Received: by 2002:a05:6000:2405:b0:430:f593:aa34 with SMTP id
 ffacd0b85a97d-4396270cbedmr12077064f8f.17.1771611672591; 
 Fri, 20 Feb 2026 10:21:12 -0800 (PST)
X-Received: by 2002:a05:6000:2405:b0:430:f593:aa34 with SMTP id
 ffacd0b85a97d-4396270cbedmr12077019f8f.17.1771611672144; 
 Fri, 20 Feb 2026 10:21:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm60474336f8f.24.2026.02.20.10.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:21:11 -0800 (PST)
Date: Fri, 20 Feb 2026 13:21:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 Ravi Shankar <venkataravis@micron.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v7 1/7] hw/pcie: Support enabling flit mode
Message-ID: <20260220131854-mutt-send-email-mst@kernel.org>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
 <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Feb 04, 2026 at 05:09:29PM +0000, Jonathan Cameron wrote:

...

> index 85694707e2e4..3c7ecd8c48bc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -405,7 +405,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
>          .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
>          .ctrl                    = 0x02, /* IO always enabled */
> -        .status                  = 0x26, /* same as capabilities */
> +        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* lack of 68B */


would be clearer as:

.status                  = 0x6 /* IO, Mem, non-MLD */ |
                            ct3d->flitmode ? 0x0 : 0x20 /* 68B */


I picked this patch up, comment fixup can be a patch on top.


-- 
MST


