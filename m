Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E45C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5mj-0007CQ-HP; Fri, 01 Mar 2024 11:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg5mi-0007AU-0H
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:30:56 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg5mg-0004F8-80
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:30:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412ce4f62f8so1290035e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709310652; x=1709915452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3o9rk8xW/dllZ0kqc9r9Xfz8W1XGg28eYGT/fgGt+k=;
 b=DzPP65Zncui6XbrJftLWfaAWrPhBERWswgBk3h8MJbyywCVT04u3vnakBm0ppcj/Lo
 ut5RIGKpEISb69L22eqjNASyp7lpyPjFWV9z4U8llPq8+uYnJ4iY2J0kjgrQY/MEJJ97
 8Y7hB0EaAiXufXgrFg3l2pId/X9L6cYKYgd3DRs8+Yr8JP0QjP26wuBXlhMryDCelomY
 2lh9rLZffjLgCE6QNgHjGACPfvjpEgSBGEFHbVcozlo+Zkq7IbNGnntvNt6m/F91hVsD
 zseZi2wWI7RUlp6gY/RGpm+Toi1qOwAZSW36d8mThQKalujsRuxkFanVOdWe/rYDRakb
 5ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709310652; x=1709915452;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3o9rk8xW/dllZ0kqc9r9Xfz8W1XGg28eYGT/fgGt+k=;
 b=c0FoVtQ5ev6nhQmD100ZgDoVNEuwjonjMg/OHPx9rsp+RxAG+eNBHT5sw1wcvd9QpL
 NMCK7XPgf+oMCBVdKZ0p4pyWswSxnl/UXsrXjLElQ3vkznhjtj7kfbbSbid9P0iQ7hHB
 5mrGMhrONAehHLvW1wwViDDWq0/skzBK4z4wFcGt+Wqf5kJ/tFP6aNiZ8IDZlIlmt2hJ
 LSOGoJEn9T/SgjREQzpVwuB/ks9/q70Bc832XAogyhpHT/FA4rBIFCQR3UaIBR/Zc2bI
 fz2EL/kZvRBUs6XnwJqxMHECQysofOSAahRtzPPIrjYAlAFOIW7fQTwIdNEyKfv4XdjR
 tHDw==
X-Gm-Message-State: AOJu0YyvI3GthpxpA7kqGuY1KCqwNMybVzQ69PYZNpeCRtK0KJoGu4jx
 NYpBu7x13dcg9RHkxVT5LW3cGBC7iH1UyXNE0EOtKX+jV49GEw6/9/zt3fjxF2c=
X-Google-Smtp-Source: AGHT+IF60cVPbGqRdH3wzG2BLa7f6sJ5tuuvEEQ1U9OYDGZNHPd+1ksENQd06Ask3Kqzn+oohRDh1w==
X-Received: by 2002:a05:600c:5494:b0:412:b721:1631 with SMTP id
 iv20-20020a05600c549400b00412b7211631mr1798858wmb.35.1709310652585; 
 Fri, 01 Mar 2024 08:30:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ay1-20020a5d6f01000000b0033e22a7b3f8sm1259300wrb.75.2024.03.01.08.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 08:30:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D18DF5F895;
 Fri,  1 Mar 2024 16:30:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track register
 changes
In-Reply-To: <ZeH6S02g5n/2TzaN@intel.com> (Zhao Liu's message of "Fri, 1 Mar
 2024 23:54:51 +0800")
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
 <20240228115701.1416107-27-alex.bennee@linaro.org>
 <ZeGBl5eJoJ0PLrW3@intel.com> <87msri5k1b.fsf@draig.linaro.org>
 <ZeH6S02g5n/2TzaN@intel.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 16:30:51 +0000
Message-ID: <87zfvh52ys.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> On Fri, Mar 01, 2024 at 10:22:08AM +0000, Alex Benn=C3=A9e wrote:
>> Date: Fri, 01 Mar 2024 10:22:08 +0000
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track regis=
ter
>>  changes
>>=20
>> Zhao Liu <zhao1.liu@intel.com> writes:
>>=20
>> > Hi Alex,
>> >
>> > I hit the following warnings (with "./configure --enable-werror"):
>> >
>> > /qemu/contrib/plugins/execlog.c: In function =E2=80=98registers_init=
=E2=80=99:
>> > /qemu/contrib/plugins/execlog.c:330:17: warning: =E2=80=98g_pattern_ma=
tch_string=E2=80=99 is deprecated: Use 'g_pattern_spec_match_string' instea=
d [-Wdeprecated-declarations]
>> >   330 |                 if (g_pattern_match_string(pat, rd->name) ||
>> >       |                 ^~
>> > In file included from /usr/include/glib-2.0/glib.h:65,
>> >                  from /qemu/contrib/plugins/execlog.c:9:
>> > /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
>> >    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>> >       |               ^~~~~~~~~~~~~~~~~~~~~~
>> > /qemu/contrib/plugins/execlog.c:331:21: warning: =E2=80=98g_pattern_ma=
tch_string=E2=80=99 is deprecated: Use 'g_pattern_spec_match_string' instea=
d [-Wdeprecated-declarations]
>> >   331 |                     g_pattern_match_string(pat, rd_lower)) {
>> >       |                     ^~~~~~~~~~~~~~~~~~~~~~
>> > In file included from /usr/include/glib-2.0/glib.h:65,
>> >                  from /qemu/contrib/plugins/execlog.c:9:
>> > /usr/include/glib-2.0/glib/gpattern.h:55:15: note: declared here
>> >    55 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>> >       |               ^~~~~~~~~~~~~~~~~~~~~~
>> > /qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 2 of=
 =E2=80=98g_ptr_array_add=E2=80=99 discards =E2=80=98const=E2=80=99 qualifi=
er from pointer target type [-Wdiscarded-qualifiers]
>> >   339 |                             g_ptr_array_add(all_reg_names,
>> > reg->name);
>>=20
>> Hmm I missed that. Not sure what the neatest solution is in this case -
>> g_ptr_array_new() doesn't have a destroy func so we shouldn't ever
>> attempt to free it. We can manually re-add the const qualifier at the
>> other end for completeness and I guess comment and cast?
>
> I find other palces use 2 ways:
>   * Use g_strdup() to create a copy (e.g., net/net.c,
>     add_nic_model_help()). But I'm not sure if this is OK since you said
>     we shouldn't attempt to free it. May I ask if the free issue you
>     mentioned will affect the use of g_strdup() here?

If we g_strdup we have to remember to free later and ensure the
g_ptr_array has a free func.

>   * Another way is the forced conversion to gpointer (also e.g., in
>     net/net.c, qemu_get_nic_models()).

I think this is ok, but with a comment on all_reg_names just to remind
any potential users that the strings are const and allocated by QEMU so
are not to be modified or freed.

>
> Which way do you like? ;-)
>
<snip>
>>=20
>> but I hesitated to add it for this case as plugins shouldn't assume they
>> have access to QEMU's internals. Maybe the glib-compat.h header could be
>> treated as a special case.
>
> Thanks! This works on my side!
>
> I support to fix the compatibility as the above, after all it's always
> confusing when we allow users to use newer glib and see warnings at
> compile time!
>
>> >
>> > I also noticed in target/arm/helper.c, there's another
>> > g_pattern_match_string() but I haven't met the warning.
>>=20
>> Hmm that's weird. I suspect glib suppresses the warnings with:
>>=20
>>   /* Ask for warnings for anything that was marked deprecated in
>>    * the defined version, or before. It is a candidate for rewrite.
>>    */
>>   #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_56
>>
>
> I'm not too familiar with the QEMU build framework, but based on this, a
> natural question is, can this rule be applied to plugins code as well?
> If so, this would also avoid warning.

I think the simplest solution would be to add:

  #include "glib-compat.h"

into qemu-plugin.h so plugins have the same deprecation rules as the
QEMU they come from. I checked with Michael on IRC and Debian currently
doesn't package any header files but if anyone starts shipping a qemu-dev
package we'll need to make sure we include glib-compat.h in the same
directory and qemu-plugin.h.

>
> Thanks,
> Zhao

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

