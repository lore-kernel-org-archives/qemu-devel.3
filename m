Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EB5C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyceK-0000ti-3Q; Mon, 24 Aug 2026 17:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dalbirrana838@gmail.com>)
 id 1wyceI-0000tX-Vb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:56:10 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dalbirrana838@gmail.com>)
 id 1wyceH-0005sq-Fc
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:56:10 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4b21f09ec76so2854680b6e.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 14:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787608568; cv=none;
 d=google.com; s=arc-20260327;
 b=dumqSkCRbojmp45rw7jL4zcErhGteQCkHgqJMIAln2ZlMjG594blDimL7e4+Ct7QPo
 tBt0SSAZg7W5RwPiGgHvlI4ZjGEdloVN8lGxca1aneMMNgrR6o97AnrgSVP4jU7eV2HG
 4hFXskz+VLl5lUiLGbSKeqlvwBH+ZFjExe/eEmGyN7uxFo1DbruP5aRG08w2GNR9KQh/
 1n0/dvJ/XkF4K7t8DV4GnBmw5RODX+5NQVMkz8TJy89SDpw4gMkck7u8Ll548RZYcz8n
 sLg8IvTEy6HyELTLHqTgydEOmb9xIA3s5q8rigizO21HxGfyICjNOhZLSxT23imvCj7X
 oWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1TgzEUnKK84BJJbNzE6RSr/gVbopwkq3xAHii/naS5E=;
 fh=80aT8exSmEubkYdfzz74SBUlWNom1q+Ldqe4lGpUTzQ=;
 b=EmtOnhWaYfDBUw9FxmFQhSTlmfCCyoIEsEmyn2jC0xctFz8iB4NMECaE6SimfTWRWl
 JH2e7l4bqn8o1jnTO66RvFyPBtp14/G8j7CAEOpFU5km/Lv9+EeDJMCo0hmeOu9loiPL
 ChXt9pi6Tm8kLj8yD8RH+KW+1xi5fDso5Rn5LAHDg/Af9qP0bh9Qh27PTJOMeEFi82qg
 6mWEm2pBquePpEaiwVj8Mx5eKLRgF6QRW1GJX/usGkdx8GTbPNPy0iU7EXX/pW1H+8N1
 4IQaXHD7WQgkqu00sTykf9JZJiuPuWOclbi4gAEzTtuyxf9HXiVf3NhLSvP0lpF6kZL+
 3row==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787608568; x=1788213368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1TgzEUnKK84BJJbNzE6RSr/gVbopwkq3xAHii/naS5E=;
 b=NGzUpahFQDTQ++IcoC1IL4uXxEf8XKDxZoWWW4N8vYSW9vP+Pv4nOE0yPMI0fL9QQ2
 xpuQnKon9d+ZymkdfFu8LMK33I0JNxlobwyV1sO59CmiDz+iF0KXQyZEhY3I1uOJeOlP
 rE6zpTJfRLaF1N7b+4A2vg/9K19Oss3dc8gIovk3cy47rBk3DTafBcBPG09znLtBI2WO
 FjxjcbQj4fezxyxSZYAtrICCM1SaDGJH46eHGdjSuRUgxIwdZKdYmPcIVM9Vn6fzW6nk
 bssG4RXbwvFWKfMM2alXUqn+5YOPV561iigRc9hPvXRXvYgprJ2MKKArEKcRqvTZOUBx
 fGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787608568; x=1788213368;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1TgzEUnKK84BJJbNzE6RSr/gVbopwkq3xAHii/naS5E=;
 b=If71g/JxiYYfFRFAOftLh90BVJ7XZ8d3WEK5D1rJM04MAdrsp5Nsc0jX1nGjTMl5wu
 IZ5YZk8ojJvNEn5ITk88lfti7cr51jCIqZbq4FhvLfVK+U0cYZO5pPMydEYUW4hO4qhx
 itrj1OqS5yNDFq3uNN8DLQkc2Um/5O1u0VuDu0cHnsXoNCtiN1BFV2Tbsev4mIJhQmYp
 DuXWbwHCXXDzk3FJImxinfgz5ZuKfdngt3LtQDXOi/6gCsYtLyneVjkekyrNVP/G8OkD
 BTg0um3EGNgiw9ZaHupisP6sC0M3mQSQGKbFI2oyK81mhFRlU/VnSBmmQlZJnxusKF3W
 SblA==
X-Gm-Message-State: AFuF++lOP0KM9CGYr38IGMUr785AwnWTrjtWuN6GbtbSBg2VzZZfEfXR
 6T6GXNqJSCQOnEzlzUtcubCrJHzCcdPrJ7qdb7y6vWFJUWbjU0O89R4FTT/rY/UCOuRI0REdFMh
 DJG7WOcLSR1wJAEGSxc/LA6IQsF7JV2g=
X-Gm-Gg: AR+sD12viUHEp9sY/a5m8kXoZX5UTEbS0bXdz24Xti1+ZSYcJG2ACFDXAJHi5jZsEVe
 SMj57l5PJpVnSZ+t6I4jZGcHB1Txc1Qjb865JsXYoq4ewAHziSukbXDyOYP9m7NdKQ4x65ds0+Z
 hp74qz1Get67w59/WG/SYgyAzp8wfZ19W3kJ17tLSTSOm6jKuUTdmUca2WPlyYGG3k+ptDncrLg
 pg2+95FTG9zD+hAUdMhA8hxo6k0tPa5xhu0lBAXbalPMLbl6OIcfYI3JUl3a3hv5Gw1jvkMJS6q
 kMlBMqFxRAmpCJRVccN+AarWrSoHL+X8vUSkTSrj3pZ3zya474bdO3dAtG28YzFXLpaICQHIkK8
 xRKkW/h5lSkPhT2pBB/6eLvpdujHZJ52s6SjdO9DrV8gFMUURzc7fQsAu+pvKx+kB
X-Received: by 2002:a05:6808:1b2b:b0:4a0:cf55:3cf0 with SMTP id
 5614622812f47-4b35066c7a4mr2146031b6e.9.1787608567741; Mon, 24 Aug 2026
 14:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAAJFZSZ+2tzVSyfe983Q=d14Xcmu0a3H41-2NdNvv0pDqUViLA@mail.gmail.com>
 <86840ce6-0136-45e9-a04c-95ca2092d21b@oss.qualcomm.com>
In-Reply-To: <86840ce6-0136-45e9-a04c-95ca2092d21b@oss.qualcomm.com>
From: Dalbir Singh <dalbirrana838@gmail.com>
Date: Mon, 24 Aug 2026 22:55:56 +0100
X-Gm-Features: AcwNN1X6Cgj0dkt3RZsF6OEK-xmvJ173PzVI11BVP40-QIsfN9uj2_ACqcc9m2A
Message-ID: <CAAJFZSYQtz_TH=eviBaP7yDkxCSqhJ0yVqH4ojXSyTyUOYszgA@mail.gmail.com>
Subject: Re: [PATCH] plugins/lockstep: document plugin logging requirement
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=dalbirrana838@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Pierrick,

Thanks for the clarification. I hadn't realised that this was the default
logging behaviour for all upstream plugins.

I agree that documenting it specifically in lockstep.c would duplicate the
general plugin convention, so I'll withdraw this patch.

Regards,
Dalbir

On Mon, 24 Aug 2026 at 22:53, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Hi Dalbir,
>
> On 8/23/2026 5:31 AM, Dalbir Singh wrote:
> > plugins/lockstep: document plugin logging requirement
> >
> > qemu_plugin_outs() output from this plugin =E2=80=94 including the
> > "No divergence :-)" summary and any divergence reports =E2=80=94 is rou=
ted
> > through qemu_log_mask(CPU_LOG_PLUGIN, ...), which is silent unless
> > QEMU's own logging is enabled. A user running the plugin exactly as
> > shown in this file's own usage will see no output at all and can
> > reasonably conclude the plugin is doing nothing.
> >
> > Document that -d plugin -D <logfile> is required to see any output.
> >
> > Found via manual, reproducible experimentation (deterministic guest
> > binary, controlled single-instruction divergence, TB-address and
> > instruction-count cross-checked against objdump) with AI (Claude)
> > assistance in the investigation; the missing-output behavior and the
> > fix were independently verified by hand before this patch was written.
> >
> > Signed-off-by: Dalbir <dalbirrana838@gmail.com>
> >
> > diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> > index xxxxxxx..xxxxxxx 100644
> > --- a/contrib/plugins/lockstep.c
> > +++ b/contrib/plugins/lockstep.c
> > @@ -7,6 +7,12 @@
> >   * introduced a subtle and hard to find bug.
> >   *
> >   * Caveats:
> > + *   - qemu_plugin_outs() output (including "No divergence :-)" and an=
y
> > + *     divergence reports) is routed through the plugin log mask, so i=
t is
> > + *     silent unless QEMU's own logging is enabled, e.g.:
> > + *         -d plugin -D /path/to/logfile
> > + *     Without -d plugin, the plugin runs and compares correctly but
> > + *     produces no visible output at all.
> >   *   - single-threaded linux-user apps only with non-deterministic sys=
calls
> >   *   - no MTTCG enabled system emulation (icount may help)
> >   *
>
> it might not be intuitive, nor documented properly, but it's the default
> for all plugins we have upstream.
>
> Regards,
> Pierrick

