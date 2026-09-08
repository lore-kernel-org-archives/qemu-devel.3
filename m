Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C67C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3x6g-0004D3-Oo; Tue, 08 Sep 2026 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x3x6d-0004Ca-VA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x3x6b-0004h5-RM
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788878842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bImJ5RBU5xXp7bR6/vNB6jiQoQ9Nu7OC5xnFY9E4MY=;
 b=PBT97Zlg2KFrw2szlQe9BS2v77yO//OdAVZeUH7G7yIJkzPmPMqwMKk48tP2BTi3oXGbcd
 uK7TpYJzFrtE/sYLF7f78y6XTfcCgrYUHwCF/gzj+Cps5I6DTWcdlRyspRMCL/1gF7ZRMQ
 tyPhDJSb5uxwSaDGQbR/jFlojnzrYKI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-RjDTf4RZMcuh5A86uuFxQQ-1; Tue, 08 Sep 2026 10:47:21 -0400
X-MC-Unique: RjDTf4RZMcuh5A86uuFxQQ-1
X-Mimecast-MFC-AGG-ID: RjDTf4RZMcuh5A86uuFxQQ_1788878840
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cced8309bso44848155e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788878840; x=1789483640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6bImJ5RBU5xXp7bR6/vNB6jiQoQ9Nu7OC5xnFY9E4MY=;
 b=iV6OR42+stzAFkPLCItYc3/9Z18UJE+nPRddxLUhoQpeQxOkN5gop0dEMTiGUwZZ/Y
 qwYHh1EyipY7r8ILF3UQl61DXBz3BghUsYmwagNZ/lz+9S9B9Dew/d156LVE2eJm8yrC
 Xu98O51slVQoH0qUs+HodqojZTnq0eYxAJuq0bY/GSCfU8MtHzTAJpAkt2npBrux6Lyf
 zPxo+jx+/R8MZDH2kEli7xok6gi/EXQfi06AqPmpFNi29hMETi09dQd+s/R/z4krz8z3
 pxGgXz/17C8TQ2SEyXoNau5jU/Gc65WUIFEPUnmlY9WzA2WDVYyEDxPHeRfEZOHEWc2A
 0n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788878840; x=1789483640;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6bImJ5RBU5xXp7bR6/vNB6jiQoQ9Nu7OC5xnFY9E4MY=;
 b=VQfelqOBZ/jKGfdfUWb2vVqcfgEyXr87nQMlgLlyxvps0GFYAGVwQDWZNfj3McrDGR
 Pl9ma5yZZCSZ5EFG5cYnaL6KG/pFrCSnHOdXbiv7NuMuNeMhQzIuOFCkr+ElDZvOMW6+
 yeOV8Sn6CKAmtMLv8US8Kp5FWEO0aF8/E18JblPEU4Rn97t14oLA/Ds8S2o+A3kITmM2
 bUP0z5qWkkomAxIKz1gvpdoCJ/eXY6HSTKjNABJLpCsaEwETZZpiAmVsoYsI2nqM780o
 Ibnh1PfonNgi8YwkRFgWd4s5oAcZiCl9sSiLLb7nUvOFE6LmpPgckg4ALo+BA9v9jFi2
 sPCg==
X-Gm-Message-State: AFuF++kr+mHTA187+TtjN165uDAZrtrUrNixHUwNpn0TsSEI8oa1bbkZ
 /ZydIia6L96bptoD0Fk0D7LOMzgH67aqr0DO72X1OWPNeUSypkoy1meIQLi/wuarA1M6TTIMiLD
 k0c1X+Brp5e/fvN+FOpdLOLR8IOXuJJqrVYzksL+JG2nIKqgor6H/sULn
X-Gm-Gg: AYBFou2voizEoa1WsJq9jRD0nomHmM1t5uEF+FdMfGXwjOzfYVS78pWyC5Y4kOK4i7Q
 rgyCVBiKPK4HMKbq35YM9giaRDzCBJ7wR48Hsd7+HDmFW7iKJzt1aFwMZZzDV2EOkZVbBfM+Gpm
 HHza+fHOs+coeyPGxEJggXUo5gEH2oHgMPOqOLcszMkkTjH5wyYkiW1Kj+29eyBP/BP62YPv1gV
 1Ah7pHG8479rNqPl4vFeOlrWH1rXzZntdPNyuIgi2Mrrcbt5FM8mOaTDK8LhHk3m4+nTAaA1h1o
 +RG1juNAdRrT8dXGOGVaY6LDP96luhAU/G/RjmI2thU65CfiA2AOjwpVg2o=
X-Received: by 2002:a05:6000:2508:b0:485:8c16:5ee5 with SMTP id
 ffacd0b85a97d-4858e8bd21dmr25082044f8f.31.1788878839855; 
 Tue, 08 Sep 2026 07:47:19 -0700 (PDT)
X-Received: by 2002:a05:6000:2508:b0:485:8c16:5ee5 with SMTP id
 ffacd0b85a97d-4858e8bd21dmr25082005f8f.31.1788878839406; 
 Tue, 08 Sep 2026 07:47:19 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859207c28fsm31361759f8f.5.2026.09.08.07.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:47:16 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:47:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com,
 eauger@redhat.com, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/6] sbsa-gwdt: reduce code ident
Message-ID: <20260908164714.56ee6a4d@imammedo>
In-Reply-To: <CAFEAcA9T+T4-n4yFT9XPPzDCyRwuSLB2TWSkCgMdFhRdTsELHQ@mail.gmail.com>
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <20260902122646.2848464-2-imammedo@redhat.com>
 <CAFEAcA9T+T4-n4yFT9XPPzDCyRwuSLB2TWSkCgMdFhRdTsELHQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Tue, 8 Sep 2026 15:28:46 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 2 Sept 2026 at 13:26, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>  
> 
> Subject should presumably be "indent"; otherwise

yep, will fix it on respin if it happens

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


