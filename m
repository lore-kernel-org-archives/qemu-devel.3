Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617EEF3D5FF
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 12:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6pMa-0004XC-No; Sun, 29 Mar 2026 08:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6pMY-0004We-Sy
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 08:35:30 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6pMW-000683-WD
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 08:35:30 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-649278a69c5so3721654d50.3
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 05:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774787726; cv=none;
 d=google.com; s=arc-20240605;
 b=XfVg1LXiylLvGN8fDr7TAv5qeutag6pxQfMg/GJp6Zx90l1hnt03EWxCteqD42Y7NK
 Bwz3klaCov/kc5SRPAoW6CjV/D1FmPBDCA8NlFzC/oOXnzOU0wPFIDP2BLSTttXyIKuX
 HNP0nNTtpnVaVIMtUH/tq4j9JVC9V7Vh/8g6oODCsZFQlm1KM+7nLBM2CYYazLs2h24d
 zz77eMKU0rF8HFkfk41mtrBq69VF/QQZmDATARMRTebo+Wj6ZMuld8W+ZxEbtXv6opKT
 AQzglBLtFYFoHfEtz7DQyFHcrSjmCHJMDYJ6UcDMX/dn7V2yZ5AG7ZPiWUC/I+cY0jj0
 bFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+q6nQVl2h0KkxHbhRc66VeEvzbqgF6Zbzia7nzZxOYk=;
 fh=gLaL7nOF2xtlRMHS7Q3Mc3/IqeloQ9eUotsoI9565CU=;
 b=IniuFjFTgyVNvFB3/HY8wZvJF57TTLxniYok+7/1ANG7W7DxfVvTFZFtij8vuzI4BL
 UzbQgydI3KCm/Nc7pSBIifCN9S+lalPL6U3/ilaFCa81o3taJ7GSjP3ETS1k0rRKapTY
 k/opDCeo+CAvVJK8IBlVES5JkpSUvG66GJAxM7Q4k9rabYbtZC5EJLPWxlGzIVNxGovX
 SH1I69IPHDgUeTHX0CA/Jf+poa4koJ2le4nS4Z7GKQCl/rrMB/x5VtMmiu4VN1iCRBF3
 SJP84ARhMDe2NCk5byagIlu91KLev5MnvhCrvRKnANFu6Oy6JC0RpBhl5N+VX/4Rrcjn
 r31Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774787726; x=1775392526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+q6nQVl2h0KkxHbhRc66VeEvzbqgF6Zbzia7nzZxOYk=;
 b=RnTGkulOzZsQM4lYD+U0Z8uMNvDLxoWxH+44yzCSwU/JuyHMqJe7W8vD0Ty93az5pd
 RLffMDdJe7VtRIcFCI+fRClMOb/Lifu3LG0jrb5UIBeioQ1RLOYRGvVrCBNYvzOgZ2RJ
 ppreGq/bNomN0kOa49nG9CB0G7rHgXxptVH5cOWCZ7BVwPAzj1mcfO+k4/VkHrEDDYav
 QQSnmoEle/Q9ymZQV1Ke22vwWC4grscz8QbuJfSxt9jIAPdVosEfshz0wvsUNdb8p+0g
 x3UfrphzgDuKMP1cIaJ8LSwsOrIIgJPekU6rAPHRouqhqaPhVFcavSxl6VTMoa9y+qdX
 66hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774787726; x=1775392526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+q6nQVl2h0KkxHbhRc66VeEvzbqgF6Zbzia7nzZxOYk=;
 b=c43kWiyfW3znyFokYDHFt8GrmimmKKjs7bqo0XEMSSCSyFjGd0qFy07vzwyzRV+oxo
 so33ns0A0ldYRAU4HX1xX5oVcttqXVCCIYBXLq6Y+FFSRazaMKFwhKXIfjGyHxnFhZHL
 bXAC57jfToFh5IU4r8otUprzZlqM6qxsNHKN67h35816tg8p4FltAK0d4QNJ3I88lWID
 nJz8dBobQa7KExhHRQwzvUWv4+HrJKAkdpiXBOAC5YaKVUDf0YqZB0ib7G1M06aQrI4C
 o7GOldIRhhSSLVl35SOmFF8zRUygmm1Gnz72irviQljK2uOZJ4CGyKNjnTLyMMIHqoU+
 NEng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ/qUdjgEI6QxHdCR+d8iD30dVrFr5kpIKZo/tnBIHl389gSYbxrEOEoExHbZzTFoesad1roKoTH7d@nongnu.org
X-Gm-Message-State: AOJu0Yz/jj+cTz26GZscbl7OxdSCN5ZS7h1KyJehgwZUmx/5AJu97Nkp
 msBJvADrXgSBkqRpalyOWW4N2ejShwSDCuLiElj56bjs9k/6SRqja6FdNYTnCp9N5BrZeCjkHyz
 kbygX95bV0Irhpg4qBGTbntduEVPH+wu5lFKhAx1qwg==
X-Gm-Gg: ATEYQzyTAjOs4chOO3w7vPpUwPREgSUAAOjRKHkvaP5jJmxP3VeT1JtBxLk/JEfwIvP
 nKqiye62FjAbW4vjumdvBKYrkwZPYugdVz8ZP/oFIQs8YOT6P/gajq8Jwb/MjzZy47Wg7mMdg1p
 tgz+lf/5OiqjjhUOkm358OfS49+j1tjSToUHsAtzANNGs9HvZ7Rz+eyhr7zuWCb6pUjkQpTzCG5
 qEAjeiGp55XRShuzyZkZ1QpMgiGmwhhhYSlzxPWh1Q5kJLzOhel99Y/BJL1sDOM4QbrVfXejoeZ
 GGLO+aEcxcHKt0tcdpkxjd/acNWHZXj7txGm5c76qzrai40apQHska1dh7GLD9TnNwA=
X-Received: by 2002:a05:690e:1488:b0:650:19c7:c5c8 with SMTP id
 956f58d0204a3-65019c7cd5bmr806120d50.64.1774787726582; Sun, 29 Mar 2026
 05:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-5-pbonzini@redhat.com>
 <CAFEAcA-O4g5ZrRdK1s5kBjMfRbWhPnD0hLZwhpVHVHVbE7LKdQ@mail.gmail.com>
 <abjXUtJNrcmSFUP4@intel.com>
In-Reply-To: <abjXUtJNrcmSFUP4@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Mar 2026 13:35:15 +0100
X-Gm-Features: AQROBzAdb8ypUANn6q5EMKigiSHm_j1hKdBPTV4iJ5CEVevgKyIhEabJG-RhvFQ
Message-ID: <CAFEAcA8FJz1WgKxU_VMc_MVGgAWk5iy2=S67SFsUSPKh1yiE8A@mail.gmail.com>
Subject: Re: [PULL 04/41] pc: Start with modern CPU hotplug interface by
 default
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 17 Mar 2026 at 03:57, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> +Philippe & Aurelien
>
> (And seeking Igor's input)
>
> > The problem is that the vmstate_cpu_hotplug VMStateDescription
> > that is being used has a NULL "fields" (it is the "stub" one).
> > This used to be OK because the "piix4_pm/cpuhp" vmstate had
> > a "needed" function that would return false for Malta, so we
> > never tried to use the stub code.
> >
> > What's the intention here ? Shouldn't we still have a "needed"
> > function that returns "false" for the cases where we would be
> > using the stub version of vmstate_cpu_hotplug ? Otherwise we
> > would be changing the migration data. We can permit a compat
> > break for MIPS boards, but the commit message suggests that
> > this wasn't intended to be a compat break.
>
> Thanks, this is my bad - I didn't realize it would break Malta. The
> "needed" method looks necessary, but previously making the "stub" one
> depend on cpu_hotplug_legacy=true also sounds a bit not proper.
>
> Maybe in the needed() method we should also check whether the board/
> machine supports CPU hotplug: check mc->has_hotpluggable_cpus. IIUC,
> Malta doesn't support this.
>
> > In this thread Fabiano suggests a fix which is probably OK
> > if we want to take the "break migration compat" route:
> > https://lore.kernel.org/qemu-devel/CAFEAcA9BzSp9F8yv4eZv5eeUM4JXSy9T-QnRr_UbJZpNmhtHyw@mail.gmail.com/T/#m6f4a672ddfa8a0a34dfdf9b57bb04e529ab5c9a4
>
> I think Fabiano's patch is a clean solution. Or I think there's another
> option: we can bring needed() back but check mc->has_hotpluggable_cpus
> instead, like acpi-ged/cpuhp did ().
>
> Igor, what do you think?

Hi, what's the plan here ? We need to fix this before 11.0
releases. Are you going to send your proposed ich9.c fix
as a proper patch ?

thanks
-- PMM

