Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412CFC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DUj-00047u-HO; Wed, 09 Sep 2026 04:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x4DUb-00047W-Sl
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x4DUZ-0000wn-JC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788941833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSd6m2An9r7YCKN/ZypM3fouCY8vDnGGD5aBpi9DVB4=;
 b=a0MZ7eT9KAbITA6rGECB9R0cuYW4r9NkNZc24DFxgGolvZCBNXfU58G9f1T4newhzElCJG
 rFusk5ICSW98sl1p9XBHwhLwnGjo1uXLHCGbl9rM1mSrjben7rbaWwS1d+6IK0+zm9fEVR
 MZZiQ/7rm3GT58hw6uofkqJIdP+8UNo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-xh0485OcNoi6GHaLYMwNvA-1; Wed, 09 Sep 2026 04:17:11 -0400
X-MC-Unique: xh0485OcNoi6GHaLYMwNvA-1
X-Mimecast-MFC-AGG-ID: xh0485OcNoi6GHaLYMwNvA_1788941831
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48597bbd963so3637172f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788941830; x=1789546630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QSd6m2An9r7YCKN/ZypM3fouCY8vDnGGD5aBpi9DVB4=;
 b=icfmmV1S5XsQxlOvMFzjSCjgfWiIGg/T7tSJY7zMdY4tlo+Gr6nAQt02k/wWAT7G/l
 FI0EJnV06+prHK9epY4eEMyRC+bY5mWEvbrqJ42s4qFGP3gAJ30caH4OR2N5TLZ2kWZo
 9IyHLaJIQS6wOErwskguq5BSsWjJjqT8AHFJffzhsKkZVjDr7BGG8rSuuiP1YoM2BDuq
 tsfSP+2tVUqLuisIEoht7d6vYGKbdt2bxMBppyw9wYNfCf6LwoUgy/On6saAn88ttoBk
 ds7oISsEMECPpxdygdnrt5zLym3OJdnWa1tZ11G+pVhQL6GrupHnAY7bfUfF6mZ0PrcN
 cTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788941830; x=1789546630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QSd6m2An9r7YCKN/ZypM3fouCY8vDnGGD5aBpi9DVB4=;
 b=EQQhobB4ry3wlqekxIU1Dc55IdtGdv/kK/tLKVnPSEs8hamqizsIXOHtt0DIWTFvWA
 Bie6gminGpSqyVOGfeJEM/ZdHaZaAwnnp7K8Z5TyTtQxVpLkegF93MM/kgqcTJxpYmZA
 KS71qpO9mFN7eJdWn3kuphHvtUklUO9IeVqVgMw6ewVsoZhdG2bnFpEwoNMsCmgz4PdY
 nm6KhzluvEKlWL1bjWr2sguU8vcboBIBlzoe3yO3e+52WCgMDRnjIzD6lrJagm0ckDqe
 GDKDj/YMBx5K3wnMb8wCYkUFc93UvOSpst3lPm3T+bMuGFacCwr0HOa7+dATq0N0JuBq
 pcng==
X-Gm-Message-State: AFuF++knWemknhJ+7lRJBeKffZonMG8SxMwdRnE1dk7w8/8M622fGVnG
 4lnv9brDuGQcC9ht8E7za9eJKL23WMUXrK1wlWEL4aJY/nN5nnEGev8eIEWj/Zm7giKi2rAvtaV
 g5FPxgu50IfyrAzpoyeu7R+E5BozofOJrZinqGBuZQZtXlDtwHISmMd4c
X-Gm-Gg: AYBFou2qeYrUvJ7vkDkab3pV5+cu+lUb1plYaW1gxiXWl390M2jEgefVxmFwY0vHPXV
 qqC0cPZnZ0OAtBaWeJ+Ya0Gys16qisQvPwv+06W/v3VGPyEM/BPmF2M468B+SihW1+dSDH02vPa
 w5MSd8+bGLvrV/qEedKo3943ElyuERDRabGC3AszciCPHOUu4R2SIFc1XTM/HgFr19TW6QYBBEP
 lTTjAIUNJyGaGdtnWM/isGKUCwJ2KPFZmEK7b8PMcBQR3+g4/IK/Wc/8ELE5G9HkEz/c45qJ0J5
 8wZE6mapk/vdweSjfjaE1M/lERHuLvNpdjoofu36iSlYSWuAgdiCtQL2kmlUT8iWhFiJ6w==
X-Received: by 2002:a5d:6f03:0:b0:485:ad55:208d with SMTP id
 ffacd0b85a97d-485ad552246mr6292461f8f.18.1788941830554; 
 Wed, 09 Sep 2026 01:17:10 -0700 (PDT)
X-Received: by 2002:a5d:6f03:0:b0:485:ad55:208d with SMTP id
 ffacd0b85a97d-485ad552246mr6292364f8f.18.1788941830229; 
 Wed, 09 Sep 2026 01:17:10 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm34825586f8f.20.2026.09.09.01.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:17:09 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:17:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Subject: Re: [PATCH 0/6] sbsa-gwdt cleanup and fixes
Message-ID: <20260909101708.23c6e37f@imammedo>
In-Reply-To: <CAFEAcA-AgMXT8LKWCH46FhqLPh1NNv84DoZz-16Ub92K_5-HjA@mail.gmail.com>
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <CAFEAcA-AgMXT8LKWCH46FhqLPh1NNv84DoZz-16Ub92K_5-HjA@mail.gmail.com>
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

On Tue, 8 Sep 2026 16:08:35 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 2 Sept 2026 at 13:26, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> >
> > Series picks up dropped gwdt fixes from
> >
> >   [PATCH v3 00/17] Add watchdog support to arm/virt board
> >   https://patchew.org/QEMU/20260624102830.1355552-1-imammedo@redhat.com/
> >
> > patches were basically rewritten to make changes simpler/easier to reson about.
> >
> > patch 6/6 is partial fix with open question:
> >
> > sbsa-gwdt currently mantains WVC in since VM start ticks, which works fine under
> > TCG. However under KVM those system counter domains diverge and CNTPCT in guest
> > starts to return host's value. As result WCV reads/writes got mixed up with
> > QEMU still assuming VM timeframe while guest using host's one.
> > Question is how should we fix it?  
> 
> Presumably we should be dealing in deltas from the
> QEMU_CLOCK_VIRTUAL value?

deltas could works as workaround at cost of polluting sbsa-gwdt
device model with KVM quirk. but then real fun begins when we
bring in picture migration (even not counting CNTPCT jump),
WCV would either diverge or jump as well => more KVM quirks
in whatchdog code to deal with.

I'd think that we would want to track QEMU_CLOCK_VIRTUAL in WCV,
basically make CNTPCT = CNTVCT and treat as such everywhere.

What is lost on me is history/reasoning why CNTPCT tracks host value?
Why can't we make it track virtual clock instead (there is KVM_ARM_SET_COUNTER_OFFSET
that supposedly should do the job)?

> Anyway, for this series, since the only thing I wanted to change
> was expanding a comment, I'll apply this to target-arm.next and
> make that tweak there.

Thanks!
> 
> -- PMM
> 


