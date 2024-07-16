Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8666DC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlSZ-0004zA-5A; Tue, 16 Jul 2024 12:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTlSJ-0004XV-JT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:55:13 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTlSE-0003iU-Jy
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:55:11 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77c7d3e8bcso716007566b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721148904; x=1721753704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9pwJNQL5TjDlheLsaizl714seAOK57vuXzverIPqvJY=;
 b=xjrvkcgTac1PQ0AR5/dkRRhz4wgkZ2i6iTSpMm5KdmGVXbUYomg1TOOXrHnjMdXu38
 BKqs9XmMdMCrxJ23UcnqQlmDZDcLsB7uBllheW0GJi+YxMwHeKZ9X4XK84vkl60MG463
 Qyddeuttm9ZMNIx9YpB6VhiKYqH5Z2FTqrLG+tv7Z16jOAtBt3EDGg7VaI3jZ4zmg3+0
 G2WNmDY2AFXaPahXlmH8C3xe2F34p03fQGhfOMeBLSB5gWayo2M3lkPFcXOi5DwYMW9e
 8uz1QM1lF4GT+CLLlkndLBPrXMZFekGm/IbuJEH+i0xLDYWEgG42wP5TPqB3uVKR+lgI
 A4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721148904; x=1721753704;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pwJNQL5TjDlheLsaizl714seAOK57vuXzverIPqvJY=;
 b=bYDe+JAvqU5QDb0Xl3mLgdgdS/C2zSoFtPcSfSIVWTapKiNvs39Izlj33ku7WDMpkm
 UlN0c4ezF5rSbdp4sdRVMREoVl3h5BI3uFkO/080erRcLq0+LtlABtLgfTmvqqhco7QP
 ajL6NCEh2NBV/OKn5nB85AJs1ergX7GvDc9LXpEOQV7eVHXLtSlee1nGI/hgDH3xLgf7
 uUlwA2sHWyd/1W+PV542/ZfKBF28dLgQTOK24o5lrzid9qwwoJhEYMeZeT7bCdLits3i
 7qDclnwsva3huy1OmPpi7EOT2oBG24AXvFADzwOYjnqw3v5oVioGmOiK5ZRxNmKITWSx
 kLHw==
X-Gm-Message-State: AOJu0YynQrwxUer/90YyRfVDnSm/nVlYlr0wZMEQGFvBYtLG9UBqQ8YP
 1I1QV9WqWRDk2C8ZKv6rsT/qJHH865cz5/gFlstBAVhZcsLi/l7Bxf1WvQG6jzg=
X-Google-Smtp-Source: AGHT+IEWFOPVsVgAfK0at++S8Xub0gng6wvQ0mu6ymNS2TkBERZaAW2260eCOg6QHFNadAEh3hQ5Tg==
X-Received: by 2002:a17:906:ad5:b0:a77:cd3c:e9b4 with SMTP id
 a640c23a62f3a-a79ea417874mr213943766b.24.1721148902846; 
 Tue, 16 Jul 2024 09:55:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b37f8sm337612966b.46.2024.07.16.09.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:55:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 17EEE5F7A0;
 Tue, 16 Jul 2024 17:55:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
In-Reply-To: <b9b178fc-04f5-49a6-992a-f6920408b41f@linaro.org> (Richard
 Henderson's message of "Wed, 17 Jul 2024 02:33:23 +1000")
References: <20240716114229.329355-1-alex.bennee@linaro.org>
 <b9b178fc-04f5-49a6-992a-f6920408b41f@linaro.org>
Date: Tue, 16 Jul 2024 17:55:01 +0100
Message-ID: <87cyndgtui.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/16/24 21:42, Alex Benn=C3=A9e wrote:
>>   void gdb_extend_qsupported_features(char *qsupported_features)
>>   {
>> -    /*
>> -     * We don't support different sets of CPU gdb features on different=
 CPUs yet
>> -     * so assert the feature strings are the same on all CPUs, or is se=
t only
>> -     * once (1 CPU).
>> -     */
>> -    g_assert(extended_qsupported_features =3D=3D NULL ||
>> -             g_strcmp0(extended_qsupported_features, qsupported_feature=
s) =3D=3D 0);
>> -
>> -    extended_qsupported_features =3D qsupported_features;
>> +    if (!extended_qsupported_features) {
>> +        extended_qsupported_features =3D g_strdup(qsupported_features);
>> +    } else if (!g_strrstr(extended_qsupported_features, qsupported_feat=
ures)) {
>
> Did you really need the last instance of the substring?

Not really - I just want to check the string hasn't been added before.

>
> I'll note that g_strrstr is quite simplistic, whereas strstr has a
> much more scalable algorithm.
>
>
>> +        char *old =3D extended_qsupported_features;
>> +        extended_qsupported_features =3D g_strdup_printf("%s%s", old, q=
supported_features);
>
> Right tool for the right job, please: g_strconcat().
>
> That said, did you *really* want to concatenate now, and have to
> search through the middle, as opposed to storing N strings separately?
> You could defer the concat until the actual negotiation with gdb.
> That would reduce strstr above to a loop over strcmp.
>
>> +    for (int i =3D 0; i < extensions->len; i++) {
>> +        gpointer entry =3D g_ptr_array_index(extensions, i);
>> +        if (!g_ptr_array_find(table, entry, NULL)) {
>> +            g_ptr_array_add(table, entry);
>
> Are you expecting the same GdbCmdParseEntry object to be registered
> multiple times?  Can we fix that at a higher level?

Its basically a hack to deal with the fact everything is tied to the
CPUObject so we register everything multiple times. We could do a if
(!registerd) register() dance but I guess I'm thinking forward to a
hydrogenous future but I guess we'd need to do more work then anyway.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

