Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B252C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiXW-00074E-CY; Tue, 16 Jul 2024 09:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTiXT-0006wR-VT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:48:20 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTiXI-00087U-LE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:48:19 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77dc08db60so629469366b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721137687; x=1721742487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DFbtaXOt+AgoITdsTk0gpy944acM9SxO1ygQwDDoKQg=;
 b=leWQwEQDDVUOMTa9WX3p06hOI3VFVLWmC192Jwrma66QfLh5U57+xbM1NBeTg8QIsn
 iaDqY/vTf3DZLQF035evcYceh9NTOzwPIdWurnhyzYs3RKCFB/B2Th7e20p6eVEAEOdM
 a+kBcUmxek4Q0vA9yiuGG4It+BK97jrB6NH0Gvv/nB50KTRSTE3SJjN/E3YGfirIXmnH
 uagMrmI0pjaeeYPnz9ZwwLl7J5qjxbjEbfT1ks7Id2+cCsObeMxuxebMAEETFJ0jOD8+
 q/u7F6buq1HKGIlLD9RM0r0K/YzQSA106kloBUMRpwzWiFg32aDG0bheGds5E2J7phG6
 XOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721137687; x=1721742487;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFbtaXOt+AgoITdsTk0gpy944acM9SxO1ygQwDDoKQg=;
 b=tvQmBw+Rls21i6kD6mZux9D2z3On9LFZOjF2JL/jyKSfF673gom49cvra+Hh8k7bb9
 UJtsrI54K9CTh1WKKkLxBqvq1Jy8Cs4ToqKKwPx54uDhGY+9VbNGFpyNkG2O/tqb/BE0
 J9XSnL5wW9gBJW9ZBw8o3aoTZMmxNiSlKC4mb9hd/YUWv1EznU7+mb18Ugq7sx2IQTY6
 LyjhiupeMTvZjvNDQMq5uWcH0xlU2lOK9wnDeAbkst0+lbiPKWWS6EQn+hH7kQo+Xq7V
 So6ygDnIXOlUfOYHbn9rqPCrAR2DuSg0WCSU0eP3JV+KtVkxXWzv/bq0wr/eAPyhqV/K
 tYAg==
X-Gm-Message-State: AOJu0YzzXHjjhaeyLCnVWEFbe9lPyauTHSQKPl0Ke9Q3kDtNUZXGNEm0
 oEGp/jIL0QsRYry9JYOad2Qu+M//SIlzUd4W3c4r14OBSBVMSv0cfAXEnl9NqurvJlbRWw6QMEK
 Z
X-Google-Smtp-Source: AGHT+IHstbTALyIvicDhJLQByNIt/XcdmwdBoHSbzleZ8bg7QTMgBFTmsR+tf6APxViEOTp2CQ6Sfw==
X-Received: by 2002:a17:906:468a:b0:a72:a05a:6601 with SMTP id
 a640c23a62f3a-a79ea3defdamr167981566b.14.1721137686468; 
 Tue, 16 Jul 2024 06:48:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5a3a93sm319615066b.6.2024.07.16.06.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 06:48:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B160D5F7A0;
 Tue, 16 Jul 2024 14:48:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
In-Reply-To: <b9690162-170e-1f74-f148-0642a8503002@linaro.org> (Gustavo
 Romero's message of "Tue, 16 Jul 2024 09:42:51 -0300")
References: <20240716114229.329355-1-alex.bennee@linaro.org>
 <b9690162-170e-1f74-f148-0642a8503002@linaro.org>
Date: Tue, 16 Jul 2024 14:48:04 +0100
Message-ID: <87plrdh2i3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Alex,
>
> On 7/16/24 8:42 AM, Alex Benn=C3=A9e wrote:
>> Coverity reported a memory leak (CID 1549757) in this code and its
>> admittedly rather clumsy handling of extending the command table.
>> Instead of handing over a full array of the commands lets use the
>> lighter weight GPtrArray and simply test for the presence of each
>> entry as we go. This avoids complications of transferring ownership of
>> arrays and keeps the final command entries as static entries in the
>> target code.
> How did you run Coverity to find the leak? I'm wondering what's the
> quickest way to check it next time.

Coverity is only run in the cloud on the released build. There is a
container somewhere but I don't know how its used.

I did test on a build with --enable-sanitizers though.

>
>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

