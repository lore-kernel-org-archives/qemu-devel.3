Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A5FE51F1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCh9-0005bE-65; Fri, 24 Apr 2026 05:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGCh6-0005al-Jb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:19:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGCh5-0004TI-1d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:19:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso57075465e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022365; x=1777627165; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XwcBXcJkhhXdDyD+XO1ZeuuHgJnTle9Xw2pCx44y2s=;
 b=IS6h0o/Yv0ifiU5uFlVnmsA9s4mdFi3w4PHW2fDULxLKTqzDO5rZjTpB4PPC4Vk4VS
 7u3VQ0p7OvGQhVjBg7EybGxdQb/jQXzh1/QNw1sqjG2BDUbyJsTxiHKbbxlF9njOl9IK
 pjiSrUs4A0DL7B/DRANL56RXgGFcF1Kx8OSHOrII00aHS5aOZ88rJ0Myge7W2uI/p+hz
 u//MMFjLyVY8vqvic5HtTe74TzmVNY66pT6J4Zj3hgTwnllFEXPUtUMAxpgA2mdS96Jy
 ls0mAiltk4Ou/+93CnX4BMtxq1+uDGS1KKZJrpwq0+fofa2l4nPltvyubUESxb6mKa43
 d3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022365; x=1777627165;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8XwcBXcJkhhXdDyD+XO1ZeuuHgJnTle9Xw2pCx44y2s=;
 b=myfXd0HaKVTH8SraNsz2FNwBkAXHiPOLT11FPTpHEE9Y42i0q7VRzoh+l7+LAgiFQH
 ZK8HhtAY6WQD/Ew5PiuKn7aaen7Sat+8622FQ9ZfvlhZAL9qSaFIggF0Jhg1YSCTyzTj
 xXEyyJRGPYdyCc8ubaXgVs0WNR/CteFfbNS8eAMTcjGknPcDF72G7uRkE7CkX5zS9xwQ
 mUvxZ7S1lpI3BmFFoG/uvbu8+LCTnAHmNnQxn8/fbvYqs0SEumNlBuqkPpPzcLKm9eXQ
 5dVnpfIqNvH76kSPkXkINA5zDzp0eswXOn3HN97DhDIseW5i2t3/YENTh6xekKq6ZBFk
 RW/g==
X-Gm-Message-State: AOJu0YwQP6TnfIQY1lwFEf3FoIHcaTBUyp6wWJYGH5eGm2sWKaPuwQzh
 fjsYWR35LmGsr+WouEf1o4dJLCL9e6k4o7/Hma+IYtwLtyY/Y3AM2k1M
X-Gm-Gg: AeBDievqNLcLyx3ORSNbI6X0Ku6AyGyIXT5gaeVupj/fmrZxyrQuyt6hMkSxIRXPPja
 DHojP9j7F5Zvgdphc91ukZEScu0rSc+riBBA5cwIpbz/ibVVEri/PJWPJQis+8RFnTu+uKVeLaR
 HijnqJ2b+TWJVfixTBF+iN0gDXRfNK5/fPheJzJ3adHy0RvKMR8yVVq+grRA2j5Nfamy4ORKaAB
 hYxRXA/AMHsZlHVYuAE9D3hIa6UJZhl3cWQ0S/fpXMekfm1tnZZu2FK1YwIQ6HD/QkDp+X4Fy4V
 MrOsMyZ3zqmXwu16ZyZdMrY9OYQrhTzYJjxOi5hAQQBnGls7wUS/N27Pzc+qk9jX/awjpY3YaD2
 /kPGIaP1p0LaEfCp4o5U6xp3RF4P29x0Qdo0oGq932R/v1FJbFqaY2fszO2q8xqvoeegb9woOEh
 mmoX3mOyXvvKhiHOSksPaGleDtZrrZESvRJA5CoCj4naAgWB4YAZPvRs6ildoXoDpgxsP7wkC0+
 6Q=
X-Received: by 2002:a05:600c:1e28:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-488fb77fbf3mr441150775e9.20.1777022365072; 
 Fri, 24 Apr 2026 02:19:25 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm343497725e9.12.2026.04.24.02.19.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 02:19:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
In-Reply-To: <aeswZxFn0zMj-3jb@redhat.com>
Date: Fri, 24 Apr 2026 12:19:19 +0300
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wm1-x336.google.com
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

I completely agree, but in my opinion, investigating UContext will take =
a considerable amount of time, which is why I took the liberty of =
proposing this patch; in the commit message, I actually mention that =
this is merely a =E2=80=9Ctemporary  workaround=E2=80=9D

So, I suggest:
- Merging the patch into the mainstream for the convenience of users =
(as, from what I=E2=80=99ve observed, SigAltStack is coping quite well =
with the task, at least for now...)
- Whilst leaving #3276 open for the time being and continuing the =
UContext diagnostics there
- And accordingly, as soon as UContext is fully functional, we can =
switch QEMU back from SigAltStack

Also the another arrangement is to use UContext ONLY if PPC is in the =
build targets, but I am unable to do this, as my knowledge of Meson is =
insufficient for such a task; nevertheless, I would be grateful for any =
assistance :)

P. S. Anticipating such a reaction, I DELIBERATELY did not include =
=E2=80=9CResolves=E2=80=9D in the patch notes, so I am fully aware of =
all the proposed precautions=

