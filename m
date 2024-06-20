Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16D3C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 22:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKPtD-0002q5-N5; Thu, 20 Jun 2024 18:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1sKPtB-0002pq-Fz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 18:04:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1sKPt9-0006RL-9W
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 18:04:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-424786e4056so2705e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718921053; x=1719525853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Klco4mKLJOKgUByMKFjjAYs1il5+49UYdHvz4iQArS0=;
 b=wOrJHw3yD7jCGcr4GVC7Jm3RDhhWtWo30oCwP3NeDSzr/okE64iRo7S9cOL2e2ykOo
 GcOMqjrEbKycOiJlp3WmhD2xRijTCLDnbcatuUIccBDep9rEa8GYgF+CddLF5kUNPlvu
 O2aYHgVQiz1BBOLzK2GCpcJeIN4rdEIoqQELV/PfOljKrj6hwOiPvenqH3OA8asLXx2c
 nKuA/3nRmmc2X4adcviPwU9B5DwU6kSSjQpu9boJEgYYo25pGfGx7Vwh2/dDbjAKiO52
 6rhkY7rqzJGwD0+3DnWD3tTYkWm5korKBV2Xh/06pzGUaFw+gBQcWAs7vGJagedQlSy9
 fiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718921053; x=1719525853;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Klco4mKLJOKgUByMKFjjAYs1il5+49UYdHvz4iQArS0=;
 b=UQJ6/M553gmIpwqfGODn645CNa/A9mnmbQd2sDg9A2gu6iAq3KVbLp3hyQWylRUXwO
 e+OSc3qA4IPlhJ5Nnjrvr4VN7W0wRbiT+qWso+o04axQHg/PpByX0zRGBtc5RRjQCF7l
 4wts5SsbeHJ4dhwv2TOm6wSM0rdodQdGfviujAZbYJ/YoeaYinlm8aTYhFERE/h4ygKh
 iUMS3n0QohrWryaQVBCuBfPzlzTn0ELeewhAkIiSjS0TcTBjQp9f8NXBloni5eT7lTkZ
 GMEVRHhr4e8+aFSoqj0uFKrt6SzMLw1bNy/ziE87YCIGaelnKoDT4ds43CsVZsa1LJvZ
 pu1Q==
X-Gm-Message-State: AOJu0YxTXkfxUHE3R9HpPjkJwBN+eLNcTcNRySTxDqoM402/ayrgA0FU
 /Rhwb7fqnbKLMTHo+IAb6F9euE2RQxuNangsmIyDr6Z0G/J7D0w4S46kYCiG3x/LoHNlv+uob9i
 syz7MtCGYyczpLqH5Q8QLm2nEf1lqkocTp3tV
X-Google-Smtp-Source: AGHT+IHlDiAAWDntjSQHt0EDxDywadqkBnfJQ4m/jD9NjuZPmPWKl17UpvEnrd0DyGmXZYD0Cu8MLBWg/+aaRI9m/lI=
X-Received: by 2002:a05:600c:ccf:b0:423:798:38e3 with SMTP id
 5b1f17b1804b1-42481d93b15mr40505e9.5.1718921052626; Thu, 20 Jun 2024 15:04:12
 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Leis <venture@google.com>
Date: Thu, 20 Jun 2024 15:03:59 -0700
Message-ID: <CAO=notyY_Jc2_Xq0NeK-0zUORy1n-6yuP5M_WXWEQnaqTmVXkw@mail.gmail.com>
Subject: standardizing i2c device ids
To: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Titus Rwantare <titusr@google.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000bd67cf061b597e16"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=venture@google.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000bd67cf061b597e16
Content-Type: text/plain; charset="UTF-8"

Corey and Peter,

My team builds lots of configurations for Qemu boards, and one pain point
has been that the qom path for a device depends on the device insertion
order, child[0], child[1] and the like.  I noticed that the qdev paths for
devices also exist by their device id property.  By default, this ends up
being the device type name.  I was wondering if it made sense to override
this with the device type plus the smbus address?  I did something similar
with the i2c mux device, to resolve part of this issue.

Patrick

--000000000000bd67cf061b597e16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Corey and Peter,<div><br></div><div>My team builds lots of=
 configurations for Qemu boards, and one pain point has been that the=C2=A0=
qom path for a device depends on the device insertion order, child[0], chil=
d[1] and the like.=C2=A0 I noticed that the qdev paths for devices also exi=
st by their device id property.=C2=A0 By default, this ends up being the de=
vice type name.=C2=A0 I was wondering if it made sense to override this wit=
h the device type plus the smbus address?=C2=A0 I did something similar wit=
h the i2c mux device, to resolve part of this issue.</div><div><br></div><d=
iv>Patrick</div></div>

--000000000000bd67cf061b597e16--

