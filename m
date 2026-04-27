Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA8BFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFtq-00052c-6i; Mon, 27 Apr 2026 02:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHFto-00052R-KI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:56:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHFtn-0005sw-8v
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:56:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so81144135e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777273013; x=1777877813; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3uLxvgN5S7wPPfwnBhMtVyBm0s7mx8jfVDh5+W9hkw=;
 b=QEzKJCYV08b/GYIam8YgGOt/Rg2T07nOwmGA/0+yVGr3AS8P1xfH5x7Ot7ETWSdupL
 1vDESnV2Xgb7/37knw2uq7+SGbbzoX4AO68+XcxqatxOu6x/YZaib5tgyQ3jZ3jQeVkX
 af2sWDbbxeFtnxFy997UGZO01vBD3iwpvJP25iCWPOtyXZiSIcwkkcDkhVnBNQVW1sZK
 c4mfddMJGFbb1dK/wlKH0n9Mbtm6LF9UwWrOmLz39WedeLucZYUehkdQfJrAyOYYMQUO
 5z0P1DJAApAsH6Yo0yls2F+zgnrlskqOpzUzJZc+IdfYHAt5L+xRn0LK5NZw0XRFcQNI
 lD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777273013; x=1777877813;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3uLxvgN5S7wPPfwnBhMtVyBm0s7mx8jfVDh5+W9hkw=;
 b=Xex2uiNdReoV+z/iOCLUZxqhdYThRotTeUeQyrKkPzXoHnfGamBGTkYmj/xfrxloGP
 eRoRZkf7O5nplFbSV+PN1jhTyMfA3FJH75HdHPf1BPXRC4De5fxGHJeEnymb+g7H/G2j
 KQJk+HYqWZMKZu0UTN8MlXAgsnH8MldhBQaoVyTvcadSRQ/E+XVgTDHTDLxIgQ8V90Ya
 b7/3tRr0fa+WFLZjZYBZBy76lLwjGKR1Hv/HkfN9kjQI5TVAoU7BIIx3tssEGJ203Fg9
 on8FiibAS1CVtm1/i6JW3XcTSRR3P/iBWGkIaEblp2CKZ1UyJHH/vdDKmmzsr3A+Zs1c
 I/oQ==
X-Gm-Message-State: AOJu0YyeyuU1I9gZ2nzKR2vfJ1Zgjow0MRYEpsEd77TOCN0dTgdQd8NO
 1O0fNRGgo9x02bdS2VFFV8XpCROzGvrm+W4E1qFCR84dvvvS4b1NEcdl
X-Gm-Gg: AeBDiev8qQDh/Qjq5y1kqzUlqd4AbjSicUSHuMG3doHa1pF1F5E2h51UW0FhADd8pav
 REv2v8QRojSNtmEF7vSQQyX2fJ6WpuIjFsfjRGtB2C9JhJMygI22aWYf19GZ3G4mO8o/hL9MLbi
 TdoSkxc55RAPBb3uG/3RxqnfcUg+/kLfakQQs5KYsKjGwnnAcnyZDzgUVgu6vEoBr7dAFYFpo9u
 OoMQUmuMUNkBqfqRkzSwK3HMa8vpR5G+zeB9U5CoDltpCchNs0ySPOaNbolBAWWEBtw0ZAdXLo5
 iEWaoNtUc3OjMMHPCv55n7WBaYBHboSg8Ygmkv3lIVz/Rou0WReIBkI0rD7jBCHHWzPAksBf/fJ
 B9nQSoIwEngryevD13iN0Bzosla/aZqitMU6haW40/D0znWERYeuzT9dPaV+xl3SvI7qcw86uaD
 lQ56KndNQpPtnZARw65ucFMAID1rSHHMorbgcMis+qPkfGsPKjOtvVP/PFKHeUIpOl
X-Received: by 2002:a05:600c:c10e:b0:488:9439:880d with SMTP id
 5b1f17b1804b1-488fb792c69mr452302755e9.29.1777273012822; 
 Sun, 26 Apr 2026 23:56:52 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm850774725e9.3.2026.04.26.23.56.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 26 Apr 2026 23:56:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
In-Reply-To: <87a4usdmcp.fsf@suse.de>
Date: Mon, 27 Apr 2026 09:56:41 +0300
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org, philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B7E6259-86A8-4CAB-8FFF-A406FA36F277@gmail.com>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com>
 <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
 <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
 <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk> <87a4usdmcp.fsf@suse.de>
To: Fabiano Rosas <farosas@suse.de>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wm1-x32a.google.com
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

Oh, thanks for the feedback, however, could you please describe the =
environment you=E2=80=99re using?=

