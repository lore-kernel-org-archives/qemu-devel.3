Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24982C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 12:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td76x-0004Qt-5q; Wed, 29 Jan 2025 07:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1td76v-0004Ql-J3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 07:24:01 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1td76u-0004iA-2o
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 07:24:01 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e589c258663so2402787276.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 04:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738153438; x=1738758238; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jjaKInOZaFKXwG5dQPq6skxdPuo9oJ4RovClDxSeoaE=;
 b=Hya6n3frEOdnyNhq6GE/U+q006uGJf6EwEip5P0Xa+Uv7+3dyA2kcmAXlziJVblKVn
 5ih6lNLV9yPMcv0ZqleJYxHf/HrrXgreWYcFZT5olN2IwO34ai4lPQbxg5r821cdI+x2
 /Sp3IA1D15q+BPuZfawCJPCJYeBbuoEXbDaimpKH6LiZdayfi0eKIdPvJEhbyuKfI3IN
 ZUWdJJ4LD8u3uPmktdZwOStk05JZEbDpMNrV8sZYgEHZ4sfmobHkDqy7qrc5bAPReWdq
 53bmwv3ozkphRBHUf7/+6RkP/0szuP/dXvAYt67Od7hwqAQ7xWv0Y5Gsv/rwiT9Xal4v
 wm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738153438; x=1738758238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjaKInOZaFKXwG5dQPq6skxdPuo9oJ4RovClDxSeoaE=;
 b=jKIxYaqra1Rwq/XyX/4l9naTJlvn3kxaKf7/hDmw5AYxSuL75FZaOx8doHw2BWd6ie
 5tzOTeH6SOtSN1JAoj0DS+smwyq0XcjNt2HqcBpeMmQqymK6G2FUiizv7sTPWObpvN3d
 krEwzSbttrgr3aU0UYVBLkgDNcHe/+ltf/FH/dS0dy+aeCDA0fVCqfh566kwvgVrEoXG
 Xyb5pzuX5VKCvUVOQNQWMqaddSsx6geQ9wUF9JAkGRmGV55+W7429QUPAae0UA5PffJI
 7ZJRYswy5Q21J7qobTtbSkDSU0yo35EyomdbGqAeUJdoCc/WNg8RvoXDeoSCxlZD9rtu
 eFEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2bzFUvxViIfcq0lacCnbYOcixli5JBjjkzxHDwhgfrmiZImnUjcDPLuIc+bjG/dTrz7NK1UElTsJV@nongnu.org
X-Gm-Message-State: AOJu0YxIdKZWM+Je5HPvDWx4VCglpfzEmFDBXKY1fuMqUYXTnoB24r14
 qIcefU9jyIsFo3qNzzOltMhPRBwjIskX9XWZtfUwMnTf/vPkCFPoM5uUCzu4eO2t7EJeKKiXLX+
 iTEe/YNx2KF+r1lE6AxhtbB2iedT+mlgLKhhw8w==
X-Gm-Gg: ASbGncuNMytvWLPTp7hHn3hKMibs95fiei1YwMeJ9wxR9Ph9PFdO/LJ1Mr7x2BWyYrc
 C/UKyKqdhoefaLvovxRSbUZbS5RjVufzHIOItTPNtCZ7KvMY+5RLIYoIBJutZMVxxPdpO5nwV+g
 ==
X-Google-Smtp-Source: AGHT+IHQGLGyG0UVeIPjhd3AXoBOVxXHlI1nOByWBoISNIiCJQGVTj03eONAJBdiTitKuRn72RDVYgN6xNQMIYhUhTs=
X-Received: by 2002:a05:6902:2583:b0:e58:8e82:5345 with SMTP id
 3f1490d57ef6-e58a4a9b3ccmr1841128276.4.1738153438548; Wed, 29 Jan 2025
 04:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
 <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
In-Reply-To: <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Jan 2025 12:23:47 +0000
X-Gm-Features: AWEUYZl4ecDSRLrG862MH7-Zp0qZG-Dun5UoZ9mm-cWF7Kmeepq_iS9vRCMnC0E
Message-ID: <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, 
 Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 29 Jan 2025 at 06:23, Thomas Huth <thuth@redhat.com> wrote:
> So unless someone complains immediately with a good reason, I'm also in
> favor of marking it as deprecated now. If then someone complains during the
> deprecation period, we still can reconsider and remove the deprecation note
> again.

Well, I mean the reason would be that I suspect we do still have
users who are using QEMU for some purposes on 32-bit arm hosts.
That doesn't mean they're trying to run massively complex or
high memory guests or that they care that our whole test suite
doesn't run.

I'm not really strongly opposed to dropping 32-bit host support,
but I don't think a thread on qemu-devel is exactly likely to
get the attention of the people who might be using this
functionality. (You could argue that functionality without
representation among the developer community is fair game
for being dumped even if it has users, of course.)

-- PMM

