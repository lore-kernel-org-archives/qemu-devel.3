Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C29EC9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NER-0000tk-Nb; Wed, 23 Sep 2026 09:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x9NEP-0000su-L7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:41:53 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x9NEO-0002Rw-00
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:41:53 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so6400685e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790170910; x=1790775710; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xs2RGIpa03heNCM+sl8xy9TMls7Du/eCjjqvVmdEN6Q=;
 b=iqHYfW9ZeMQTQQ/B108gJrJKBhfluWvXDMfZgB+R9g1db/PaTgf0Gach5/LIqZkIS4
 wSS+HhdLMVyBdoqH/sbEgO9BLCHpin/hMnOL00Wkx5+fOuRipsA6HZ9M0u/nTH62Kr+y
 xQCWINW5xL6hJAkUjhlIhsL3SqyOjgbBVBa0Q343nXc4BNPk49Ap8k/axHIJtaOna2lt
 ZkdycLh3bTpfH32iT9bMUoWf4i7y+utXAME8ro/uTywOehSwhAaabnhdoknnyBvRkQgX
 J9sqt3leA8IoX/1LYMmBYI3o+UGPDSUXI0IhkChmPfl/0r7wqVzaTQw+244yTgIPb62Z
 lrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790170910; x=1790775710;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xs2RGIpa03heNCM+sl8xy9TMls7Du/eCjjqvVmdEN6Q=;
 b=jv3yxa9Tzl/JBZruOIMwt9xGkMe8wxwc7hGb0LQq9Wk4Q+t7eNVUNJ1PXQJ1D2xCl5
 P5GEdWKR9vU0PcXyTGHcWrYFt67je7cLHR6AIH4/aribX3TOiUO4aYI+L58gTspvjPvT
 +uhvZLU4E92JnqV9KPwebsl4eQb4uhNbu7jXOWbgpWNSDPgButrrY0nzdRx7vxC2gl1k
 Awu7b2yRqNVERpX6Q8V18fzwWVaNUVUSulAc9qvdZRXtsE9M0vomYOqEaVX5waOu1M76
 WHo1b8I0fVZ2r6o6aZbrPGzHdlu8IRuOKXyRSDddgXoAjWDiaUYbGey27+GoT4ZVodXI
 4k2g==
X-Gm-Message-State: AFuF++loITknW0OiA26yY3lkJ+sFKwExq//Ftew3rueQaRnPCpKbmBYQ
 xxmmnkp7f1fXbDwknuLhghiKl0ZvBLi9AfgJYq0zN8S1o8L8/TTyZMdc5WlvC9OJK/GD9RHKX7Z
 DGi9i5OU=
X-Gm-Gg: AYBFou2ssDtAn8bkqBPt2BEPBeILtaNq/rf6QsaluQvp5uqBaLVxwlR7f77Mvz5nJLq
 lkX9HXay2Wo/k6GPO1CBxRdNvAsVyPeIfnqyG+aoMBou55LkcNc3eItzzwXsCispoK+V7S/fbKv
 dwkayPwfpSeNmGMta22/1MZzmwjckZB5aNQvtQBAScvvRebV8FUnn4X8Z44FvzgO8bWC1oVa0MR
 ySyQuWFv790+0nwQ6FoeXRD7rF2GrBvs6wxiPDE2KU5us0SkdUFgTPv4I65uINIlLjboLJTIxGZ
 aCE6W8eOuPEWQIUnnn66PdlLhAOt8kxaWItYKKaFnZkCN1uzCt4EH8PYUfdFyza1Mrs2ujVa6m/
 fTyAk2OOB9uXgg17ZA2+Fl6gCRD5Nr2KeWShZ6jAHzpyOiuhgkC5Jg0Ivc/u375go1LIaVE3V04
 9ywuMD/QfupcJcaAfhicdcgxz+gJwdWXG0tREujQDj4LsTkKc9HjA+CPQ1ynjO5jj+d9hFuMcDf
 a97CnyV
X-Received: by 2002:a05:600c:c173:b0:49c:fc6e:8caf with SMTP id
 5b1f17b1804b1-49fdf12b782mr41199845e9.19.1790170910366; 
 Wed, 23 Sep 2026 06:41:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1e045dsm83704075e9.11.2026.09.23.06.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:41:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 126195F8B2;
 Wed, 23 Sep 2026 14:41:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  yodel.eldar@yodel.dev,  pbonzini@redhat.com
Subject: Re: [qemu-web PATCH v3] blog post: some notes on the bugpocolypse
In-Reply-To: <77608a72-d61e-4a6c-95a1-85e940260bb2@redhat.com> (Thomas Huth's
 message of "Wed, 23 Sep 2026 09:39:39 +0200")
References: <20260921075850.1322075-1-alex.bennee@linaro.org>
 <77608a72-d61e-4a6c-95a1-85e940260bb2@redhat.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Wed, 23 Sep 2026 14:41:47 +0100
Message-ID: <87o6doytic.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

>  Hi Alex!
>
> Thanks for the update, the text now sounds much better and clearer to
> me, I think this is close to be ready for being published now. Some
> minor nits below...

Sent v4 with the date for today.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

