Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D98C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lfM-0000GN-Qp; Wed, 02 Sep 2026 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x1lfH-0000Cv-Pb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:10:12 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x1lfF-0005xb-5x
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:10:10 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66c7127a73dso1042168d50.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788358207; cv=none;
 d=google.com; s=arc-20260327;
 b=dDNiqx68s2FBj0sPN4HNVUfjLEWQnLDSwGPklR6ZglYBtFFG40kHMZ4yMAKz1rHT8g
 klSapheukgtKjCwtzWSm4PmGaQNrJzVyYKL/EgVYT+Go23srxpN1MNAwioA5BMOPkzqu
 dPjswTmeMzyC6Icy0oK3R/16oq6w4nyYG6sd/8/n/plN+UhMxlh6P0aSFnXaMk7+1N2/
 bwhbzQnZhV1tT3CHGSHu904ieTkRCdbGn5CNR31Z0NpL5zOv7IzQM3Rf3s85igEpZMaM
 GmjidGgqoCKNQINk+d78h7gFmJCmClEvYLtRp1Pa+xA+ozhFRNTfCG0qsG2zHmFe51C8
 UOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/Cfhj5NvYuKqo1hjb3Z8HMfkxajB5eNOkuUUkYEWWpE=;
 fh=qsxN197plMR+FCQ92udk1Ou/A/4bFspG7VS8f13tPkY=;
 b=m2Hcp8BvxxMPpaz4Gxqdj+163CxxXcSy5Qh1fkoOjPZl4NfsbtaR3jCGsg1UGqRMFn
 w6TokEeEHkV3OGuSJsOJoLCzT0PtPoj7vyj6kWUM83xUT/zAkt37GdPNmlpunfo3Abp1
 AIzLsQzOQFluEB+bMCA93iwxplUQkYdAK6aIZQ4ojNmyMxEaEdb1dygH7Zm6GrtZRo+5
 DQkAbM390dmiNlgPXjRntA72aGLc7yb2xU7zza3Edt8Cva8prP2KpHHndL5pHEzj0/Xx
 Gx/AM9yRovbckqPtRaFYisZ3gKn644xhUp1XQxiq2PMlj2b2L3k0LvTP6ha6tP7JM0+2
 9hAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788358207; x=1788963007; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/Cfhj5NvYuKqo1hjb3Z8HMfkxajB5eNOkuUUkYEWWpE=;
 b=JUe9aPpo13mLWbosHkcnipaTBatnKl/fMfYlKGhyFbNuHKsa3wvYvFDT2whg1kU/wX
 Y1N9dH3lTMJaU/TJexcagGNnk1V0oz0R/YkF+zTZMllPbqsV+NjKECf0Urnpf5MzTGqz
 bxP98jl23YSmb/+qoY8nZ/6vynX8bVwUd8YSB4ZNst4gUbBRidP5W6iaWbOAOgZ9OBop
 mal4sOcyoVYKl4pY3h9p2bviAMHgR/0n/wJmeDm0DghutGlsnXU436TpC5HdMMld/tuQ
 hk8/JZXrz6mhrLrMZhmVJLzwvywIprQSTKlc5KCTby/y6Mt8/Q3il8//baH1xlsp6m2J
 cB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358207; x=1788963007;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/Cfhj5NvYuKqo1hjb3Z8HMfkxajB5eNOkuUUkYEWWpE=;
 b=QTth1SdP8adkgNvMU6OQA+BlkyIYlIuau/7XkXc/GmhAxdiZ2q27v+A3qbmuag9HZY
 FzG4H9tJxj7xNAhK5s/4cCDlyGbFekqa5gVNc9WcE0a9nDhT+4ikeRI4oX6eWb37yxgm
 ltoBP5lrWutCSIPa3HTXP35JWkRMaAAYN+K/uMqNkq0ACL05SCvorCfAfljN8v5zpjUY
 T9iIe7KfhEyiEDua2CJx/TsktNcrH7DTexUhetcfW5HjJJkLBpHpXks2ceV386VFELF+
 owj71i/WAjnCx1n/r2OQjVnZRDuEsqHPR9XztEPMpoYxGBaNLdRmochPwrrlG+NP7oBl
 mzcw==
X-Forwarded-Encrypted: i=1;
 AKwUvByo+Fg8HgBkKoJiU8dZAVaiYrRWKvoBX2+UbbRen57pfx+ktCzrYhGi/y+M9nPxugzKJzdDSMD4oJkw@nongnu.org
X-Gm-Message-State: AFuF++k8O3iaPrinGk+GGecWU6TAhxBukBprX21nOgrRwsGimuaH0/OJ
 aYbpsbvbcbmvWn8w0vMIkBd+sWv7YLpdAmb7ubgUk9Fv0OOZgF7kjhz83cuKumgjAvIcBS2YuwD
 tvSycwzoRL0tLfb4MDsFzrJ8w97xdfZQ=
X-Gm-Gg: AYBFou2SP/FRKDugEga6Bcp557TvRszb/wULgkI1zHRYaTVBVHtwz4n8iYy7qNW9FYk
 JUWSj54kqLYudlQziBbJKnIWJemfXvuap9M20ILQAaMDx9EBavOYjzCprXOrwZIcOW+EFYRyTEV
 z8OAawAXLG/Pgg2g/h6fkeSz07jFKa8VnyIXN0voLXscjgk5sGvClFMh4/VWZG9WwXHYaMe1TXA
 sk9c33wfQ+7ZxVvMoSQFJ7lTA2emEa/PRhvaoouVTTCrEtAVseKb5W/WO4VmnDMrk2mgMcrUuhl
 XaGwkfS5RthwdpmYOGTldnGkhfZsGEQwUoinwB1BO3gV4UpwmULztw==
X-Received: by 2002:a05:690e:484d:b0:66f:78cb:9fe0 with SMTP id
 956f58d0204a3-66f9bb6fcdemr1424456d50.21.1788358207306; Wed, 02 Sep 2026
 07:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
 <20260901212226.GA736562@fedora>
In-Reply-To: <20260901212226.GA736562@fedora>
From: Huiba Li <lihuiba@gmail.com>
Date: Wed, 2 Sep 2026 22:09:55 +0800
X-Gm-Features: AcwNN1WRMxN0AlDAeuo0MK6mfu_2SBXRXd4FuDgH2WSGTUA4jQZ3HaRtIRyKAVQ
Message-ID: <CA+AFTT9GX5DGeiQXde0KOM9=5CSGcOPdEbt9ZEhPmFzwnZCdwA@mail.gmail.com>
Subject: Re: [RFC] block: add an overlaybd image format driver
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=lihuiba@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Stefan,

> This looks interesting. I've pondered whether the layered and immutable
> image trends in recent years can be used effectively for virtual
> machines.

There are already some examples:
https://www.databricks.com/blog/booting-databricks-vms-7x-faster-serverless-compute
https://community.fly.io/t/experimental-speedy-machine-creation-with-overlaybd/18958
And secure containers, agent sandboxes are special forms of VMs.


> The advantage of a block driver is that it has better integration with
> QEMU and may avoid the need for privileges.

> By the way, I see that overylaybd already supports tcmu-runner, so I
> guess you've decided that the benefits of integrating directly into QEMU
> are worth it.

Yes.


> >   4. CLI surface: point -drive at the OCI-style JSON image config
> >      (which lists the layer blobs), or expose per-layer options?
> Both :). Per-layer options allow for run-time (re)configuration or
> hotplug using blockdev-add and similar monitor commands. Users may
> prefer to point QEMU at a JSON file rather than building long
> command-line options.

OK


> One thing I noticed is that the append-only format used for the upper
> write layer is not documented. I guess it's different from the read-only
> LSTM format since the index won't be kept in sorted order when
> appending.
> Do you want to document the append-only format?

Yes, I'll document it later. It's only slightly different from the
read-only one.


Thanks

Huiba

