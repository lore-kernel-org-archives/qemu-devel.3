Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62CAE95A95
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 14:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaaN6-0004VE-FH; Tue, 30 Dec 2025 09:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vaaN4-0004T8-IJ
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:46 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vaaN2-0000im-NU
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 09:06:46 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4eda26a04bfso130483061cf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 06:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1767103603; x=1767708403; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=66bISrM54aEShqNVvDwKzt/2Q+oJEmylKwxQsZjzI1k=;
 b=QRBdoSTfp5qBGrAml0N7AbzX8nqUMnbtkquGJS5w3HzLLFnOlY5JNP8r9+ib8CmkIJ
 1EivorKpkb2pDR4XtED5gA18Rz3bGli90+xrpeUuvGvJB2uKl2IWNLHTUWiKQSgP+bSA
 TVkQ5oauDWOpVaQuNEhPgn9wcY+Rp5k/PykgHHHVbfTx5PjY5joshp2tOv2S1vTpe00K
 PqbCUvgHNAXL+S2ElrNT4/1470Poepert8KwxkoDgklx/S8LU2XO48LtVkfxn62izgL8
 TKbvnIKm4sD25P2gSrL4o0HdU27PcZFA1iB2L0EyjXsYuXe8Jf+XvTZ4biwsSB9r/Bi7
 FG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767103603; x=1767708403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66bISrM54aEShqNVvDwKzt/2Q+oJEmylKwxQsZjzI1k=;
 b=ve4EDSpmuRxKWrowe/lVrv8tVZM7krSY2Dfimt7Dz9Bq12xVoOdu/NZFpeVDS4jpJ4
 9XnF6HRvlAyfNka4aXg5Wm9wk99/dZZ9Ilbt5remB7wZLkAQbRg5ss5tTfcKGsL/rRkh
 XsKNWjvYmCwVTA8jlO1M2ZP00R1m6Bxmf0p3NaODt+wb1kF7iyYj66I7eyfpOpvvhhgQ
 0CPgwMdL57Rlu0TFvG25Hou+RjNphd7c86ZWU+xJmTk4hAJ74Dl7MQE/+B8rSoBgtGYV
 NAjal02qtIAGfjfZmOiE28PZ7yCKl7oI0KDS+zQAapqFb5aCvJIk7gUdVnl0RNPzEo19
 31Xw==
X-Gm-Message-State: AOJu0Yx29mj8t7xJLKjNy6+morK8pyQ4tVBT3UtOzPeZPxdPKFnHwkDf
 dAMwOIKoI7UulJYEvmZxdXecKAArd7WOU+3cfI3mZIkA/M/2USndBgFKkBaxQef1XsM=
X-Gm-Gg: AY/fxX5bf8n6ad4ZPVapwZsD1StH0mUiZD2Lrh+JiL/FuKtoSVR1CJFBVAgTWthK6j6
 7A9VyQrscwauGsZXSeIkXqgMDIuztWcep5/xSclzr4sg11ubyOJxEu9NFZU31qIpkpR6pdU0Lv3
 OYSKLYS7VXGQbEoXPvtcWed9VNUPZakr3hubuqOolHhdXv1OzwIZ9uOMYOpuInroaOFQjQAoaX0
 wqgulcV79MzEfydV5vsX+oqyc+VgbrWk8iGM0gFrGVuhU33ufjoLKeW1otvEBOwxhbKptVBW7BM
 mZLVviFWR4OlVByfCs4NaBOJTqA1tzwLWQKA30zvGQJAtnOK8sBp39CM+G2cJIUU99I9283Xb0T
 E0/aSU4J7qHqGUV8zni8epNEjJa0s3S7xLGCq35lCo18spfDn+BNjtQizRHGqXc4JQWFcppjLYc
 RVxZoUHoMmq1mjB6xntCbWzbPAwxLjrMhxelQUtHMPoYvyV4Xs3vkcHAf3qc/7GHEn6n4u4A==
X-Google-Smtp-Source: AGHT+IH0HWx3Yil0Dd/9SCXD/sm3AHm7LlYzEpOdcijhkC0kH83+BMWtrGGPbkPR2zif6DzqlIjyJA==
X-Received: by 2002:a05:622a:4010:b0:4ee:1c10:729f with SMTP id
 d75a77b69052e-4f4abd1f227mr493179001cf.35.1767103603122; 
 Tue, 30 Dec 2025 06:06:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ac54a6acsm261741201cf.8.2025.12.30.06.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 06:06:42 -0800 (PST)
Date: Tue, 30 Dec 2025 09:06:07 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <aVPcT_APo6SgRrGU@gourry-fedora-PF4VCD3F>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <aVLH4mmbDSp7ZdVu@gourry-fedora-PF4VCD3F>
 <8123efd8-73cc-4dfa-9f1e-6d9a95f66984@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8123efd8-73cc-4dfa-9f1e-6d9a95f66984@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 30, 2025 at 10:55:02AM +0800, Huang, FangSheng (Jerry) wrote:
> Hi Gregory,
> 
> > Sorry i've missed prior versions, is numa the right place to put this,
> > considering that the node is not necessarily 100% SPM on a real system?
> > 
> 
> The decision to add `spm=` to NUMA rather than the memory backend was based
> on
> earlier feedback from David during our initial RFC discussions.
> 
> David raised a concern that if we put the spm flag on the memory backend, a
> user
> could accidentally pass such a memory backend to DIMM/virtio-mem/boot
> memory,
> which would have very undesired side effects.
> 

This makes sense, and in fact I almost wonder if we should actually
encode a warning in linux in general if a signal NUMA node contains
both normal and SPM.  That would help drive consistency between QEMU/KVM
and real platforms from the direction of linux.

> > (in practice it should be, but not technically required to be)
> 
> You're right that on a real system, a NUMA node is not technically required
> to
> be 100% SPM. However, in AMD's use case, the entire NUMA node memory (backed
> by
> memdev) is intended to be SPM, and this approach provides a cleaner and
> safer
> configuration interface.
> 

I figured this was the case, and honestly this just provides more
evidence that any given NUMA node probably should only have 1 "type" of
memory (or otherwise stated: uniform access within a node, non-uniform
across nodes).

---

bit of an aside - but at LPC we also talked about SPM NUMA nodes:
https://lore.kernel.org/linux-mm/20251112192936.2574429-1-gourry@gourry.net/

Would be cool to be able to detect this in the drivers and have hotplug
automatically mark a node SPM unless a driver overrides it.
(MHP flag? Sorry David :P)

> > 
> > ~Gregory
> 
> Please let me know if you have further concerns or suggestions.
> 

I'll look at the patch details a bit more, but generally I like the
direction - with an obvious note that I have a biased given the above.

~Gregory

