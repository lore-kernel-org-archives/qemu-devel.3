Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEAEC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zRN-00054g-Mk; Tue, 22 Sep 2026 08:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1x8zRM-00050b-7u
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:17:40 -0400
Received: from mail-ed2-x14.google.com ([2a00:1450:4864:33::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1x8zRK-0006EK-Jy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:17:39 -0400
Received: by mail-ed2-x14.google.com with SMTP id
 4fb4d7f45d1cf-6aa0ee64afdso4789911a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 05:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790079457; cv=none;
 d=google.com; s=arc-20260327;
 b=Ges8BtVkHjHGJrImY4AQTKDdF/esXDbUosB8Ya3J8cHmmuulpAbn33JnrDLUDXX43s
 7w5qG4L6AhO2Ke6+8l3ikdiRGcharqkB8EQloXS6B2ia4QBoFgOZDzUM0NEdLmugvnN/
 0oisZ7duJHWRaH3dweHWveN6zGoqcfmVYQGf1ATHHtUdf3X0hz7lQfi8f4FT1II7OKUd
 At4v9yQkJxUGqKfhPBP37zghK+bcTayJB53vsCfYYpYA+pzkCjrxWbjF33K1bTi/pYsa
 anz+4sClvXjZfeDGBh2EyAdDkOfF+D7Mf9xo0u/aTA0/3WXVyXn9XccNOHX8eSGpxEeE
 M08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ASjYIuAjuaXvIJVSzgr5JJsA2CW/9tYiiLDfylvRkE4=;
 fh=9sic9NYhnKLM7mZVJYq9/DKYLPrHRQhpX+023FQ1vMA=;
 b=bZ+jfIremoQZww8oALgsVNk0elSe19t/imgfwH/ugC2uRgoWok7L87F9tROc9LZcMB
 dgq/Z5oRipdI8a6jl0xx2hcoXiCy1jaFROOmOrDYtHC2HayMXFqk6I3X5VOJASjgG719
 AgUXUeEYW06YSASwYS79JOB0SMoEhq1pjBWTFrhDR/dIJMaWIHOyZIyk+wM4MojBhJiY
 n9caNlduneeUvtuWelzCEwsPIDs0bSiPM32/ff4KMlWrUWkWT42DU5lAK5Su+e7bZSkG
 oARmumDA7fQ2F/GJ6R0pvFF/u6aJkFiBrBSdlxiqtyXT/HudodOLHXj1dqBK+Ig2w6Hl
 aRAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790079457; x=1790684257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ASjYIuAjuaXvIJVSzgr5JJsA2CW/9tYiiLDfylvRkE4=;
 b=TWePvafnLNtvmubOKMP+FkR07jIZ11myKPTMNbUXRPYe/Rs/WMCr1A1JyuxwRSSK2Z
 MWLIPETTRvjqb1gqDeOQRP+4v5dpt/94nzFBV6VwXm1M8/PiV1cL1bYlFeXJmIX8YVqw
 hu2LtSkYfgnFDRJptiAvKqdqjoiYpJdwG1LfdpqawmVBJ8ONjlrvwrdTCJysgfjMqed0
 r8sJCex14T1msRIy5I8VOzUiWawfNpshje8Xr61Uxp1VerSjTsj+9Vo7Yyn8CHxkgcJe
 WXGLmg6q+pndN/J/VfdhlUZ5e3FWOA/xx9hnRLh1Kp899f9dNM+D+7fqYry3gf1UD9aw
 avEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790079457; x=1790684257;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ASjYIuAjuaXvIJVSzgr5JJsA2CW/9tYiiLDfylvRkE4=;
 b=HiibETB9D9kZslVM8yRD5yMZqcL3tMT0bfjq70bxGUcEzu8yDPtynFW9iFiWUZPIx8
 bJeZc6Ep1wiobYA8a84gLmNn2QKOGVrDhIOT7luvbrsAPZ5f2rVXAe5I5DAyFtwddxtu
 MZp5nCy7ZC4EDIudfX4hCblXNzUTHLNPtqFLay95A693iISwsDQkelCsTQP5D1X2c+Sy
 MLPMgsDBtCORm/2SYQdEk7jkTL6i3m3tjogNmFoBYg7g4K8pldwLvhD7kLFCoMfzyQOE
 /yE4F1nxtYi7uoj7L4+cDTwHHHUJLoZXX4l44/DKxH+WshpNLEwnp7njdHc/iVQC0wKc
 3QxQ==
X-Gm-Message-State: AFuF++kiE6Az5YEhg2q55BT3kMoSDd7NKb7r887zbIWYUOFdfH9pfAb0
 Aofn/tnivRxl5DIlY2JNMRxkARCl/amH4bz63Qq5LmW7hbzniOmiZRgaCJueRUEj8UPm4YS82D/
 kOY56q7Vc1CT0q6cl+U12bJhuxT9Aljg=
X-Gm-Gg: AYBFou0t+T+AFqcJUrwZ5tD4igflfebwT8dNlYY3KAs93ieXOI++R8KZr7LWbP44kYP
 mHgQJWcujAiyBxLA7zAvIUoAafZHrXVFxCgU1LMopJo4DiwKXfXin1OsJcJ3l+/bUy9NM5KoNpk
 ZvdUfI6XOdm21mzpi49LwvAmYmdwoVF1s6VaUf4dJP7WIMFlIWLviDcom3OSkfpqvIdhLQKUJgy
 9+qcwvHPhqVg9eD4Ya2upcIA3pEv/wJ8DB8BS4cAWAwRRJTUKGBbMaXoaX241uqB4OKaG9fJpsZ
 A2nQpNvnno92fmEWLt7ZJBbJblgUvYwojgMP20+WNC5jqgaBp99nAEljhmLIlHmR2Pc3dTtT8N/
 cVVqcO3nLHAi5/f/l/uOplHA=
X-Received: by 2002:a05:6402:208c:10b0:6aa:734b:1a33 with SMTP id
 4fb4d7f45d1cf-6aa734b1befmr5979110a12.45.1790079456324; Tue, 22 Sep 2026
 05:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAPF+SGdq9yngvDxCM+YeeaF0HKSkN4TgE0KK09DpCdEqPczYOw@mail.gmail.com>
 <CAJSP0QUMjJ7J+_=jDO7Ek353-DnShz0deRDHi-WQ4SVMwp_rpw@mail.gmail.com>
 <CAPF+SGf+PUNOS=gGZZO_FtanDfhGrq_7o7X86tq8K=j8_PE07g@mail.gmail.com>
In-Reply-To: <CAPF+SGf+PUNOS=gGZZO_FtanDfhGrq_7o7X86tq8K=j8_PE07g@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 22 Sep 2026 08:17:23 -0400
X-Gm-Features: AcwNN1VnLZ8W7eGY6TdWSFTaE26TOQJwItu_GsOtpwr-84YddQUbm5KWj2yedYA
Message-ID: <CAJSP0QUvfoaqf+VVVHTmMx8fZg_1z-=dXiUZNDsD4hPRfN5X9g@mail.gmail.com>
Subject: Re: Deferring FD read/write to worker thread while vCPU remains halted
To: Irtaza Hyder <irtaza.hyder@10xengineers.ai>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::14;
 envelope-from=stefanha@gmail.com; helo=mail-ed2-x14.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 22, 2026 at 1:57=E2=80=AFAM Irtaza Hyder
<irtaza.hyder@10xengineers.ai> wrote:
>
> Hi Stefan. Thanks for your reply. As you have pointed out correctly, I am=
 trying to implement out-of-process device emulation and hence require the =
blocking call.
>
> I was unable to get the memory_region_enable_lockless_io() to work proper=
ly. I have assigned the memory region triggering the blocking call to becom=
e lockless, verified QEMU treated it as lockless as well, yet the main-loop=
 still got stuck waiting on BQL. It seems the BQL was taken by `do_ld_mmio_=
beN` in the call stack involved in accessing my device's memory region. Add=
itionally the call stack showed memory_read_dispatch being called twice on =
different memory region addresses (physmem and then my device memory). Is i=
t because I am using a **SysBus** device?

Hi Irtaza,
I can't say without looking at the code.

> The spapr_rng.c approach is working as desired. I just want to confirm if=
 that is the correct approach in this case, or does a better approach exist=
.

Great!

Another approach is ioeventfd, which allows kvm.ko to notify a process
without KVM_EXIT (i.e. going through QEMU). However, ioeventfd is
limited to specific types of MMIO/PIO register accesses and is not a
generic solution for handling memory region accesses in a separate
process. If you are implementing a specific device outside QEMU and it
can take advantage of ioeventfd, then that's the most performant
solution.

Stefan

