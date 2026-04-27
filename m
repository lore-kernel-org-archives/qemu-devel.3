Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3B5FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNvM-0001HR-09; Mon, 27 Apr 2026 11:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHNvJ-0001H7-9M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:31:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHNvH-0008Ll-TR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:31:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-483487335c2so102217675e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777303858; x=1777908658; darn=nongnu.org;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=dWJZx0Kvu0DnWprjStWbDtOolsClmZ4WYlcUNdf1jfk=;
 b=UhqlIrIo81yuJeGKQAZqI4+G7/kMLI6E8etvMxRe0KkR7U7C4V9DGrsJKr2hb5XH/y
 +q9BqboTSqXKgvAOIcvkEJLNJS7rPVnt51fGFHZqe+qQDP3+5pZn1LTrxf26sT0BcpaH
 jnKO5lj1s7IxGzgGqetwQHEy+f+7gTYTT8Wlc/6do8wp0JvfWuVp30ZfDz1+ehX3NTdf
 mH2MGU6FXyJUralz1uF7YX31Hgio8i9p5DsEhq8WXY3DTeNFwZXfUAfyXkVHKFxGwdBi
 VQpFKQotJsyVUtmZL5kB/DW33Y4R8sAduVcX05+AOSYCUBZ/TIz3PIcZMnOMC8KSyTVc
 +DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777303858; x=1777908658;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWJZx0Kvu0DnWprjStWbDtOolsClmZ4WYlcUNdf1jfk=;
 b=Ewnf5aPTMJqDaWooGCeBd+XWBM6I6GV/4mT8DRUbuc8Lo4fF/Blk/1w8dZJmMKRDyC
 /A67/ndpdaZ1K1PFmoa95SgOzdpxRGZK8kfhCwehlOKsoWhBRyuQPCXT4R591+Db8m1r
 TsyWABv1AmLSjtcqzBlPXjQVuynEwjaLJfMA4A22YrQizVe6e8KDL9Ma+pJ+nx3F3WLo
 XMJTR+kqRUp68dcCVXVoHaPyPfn9NN6GvqMKzOaeqk/pxQI3RhzFezAxCA8XqYNd1O3S
 6H52qtuvDhOSnwJKHS7E/I/4f2M5sunweluJ9zFMAkuLCoKhg+5zd1PWbBmDd+fSbkd9
 swcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LbgTjp1ikoHyW7ye1Ki6COyKxWg7p9yfBPxdIzNSP3d/WxclIxhRBvIm/o/xoKo3Cs1iL0NHsgmtp@nongnu.org
X-Gm-Message-State: AOJu0YynntvHJY80t83or0zdktC8879O95XQ6uANE2tTsFI7MEnQGqit
 Uen1BeL+R1zGHWFqIWMOyA7tnGTvoIfLIOdv+Stkpn4/Lu3wW3cWgwlh
X-Gm-Gg: AeBDievSNfb2mH8KBTHCKkWH6Ud/KoSgf2l3oIRWjd4sOp+JciPp/ON1aVxPrwb9vE4
 KM5Xo1er1VqyTxyb6vGaiKkRz6v5iuoP0Wtk8VI8mDU8DpJY+tZ0MgY9LO3itSZ3jU0JzF2xVHQ
 lnAPf/xJ4E2ssPujNjb0lYO5PH4rSLoND/9CCjFm1HVOOrKzeZOAsyK2eEjnkxd0kWBdwMnBsZQ
 oMXzzkHWqxZes39waogDj88ABmHYOWfa1kpx1wNg2hqKDMjSagOi8YBtGoZyiNM7BHX9S/0ElSn
 uylYLS71IAmPrxL+XVLIk3YGbUrms9M96l6+Cc+Ugz1TjGJvTWATLmAGv7oRCIukIT1kjq8fr+0
 9URhVmRL66fc9cewRVbQybkwdCRBUtAQz4W5vN1QVEtjYeZuyMuJqtooLi/l/bmxKBmUfCa/sNw
 F3/I9nqLppErbbZVAx8c/TPH+cxw9lz76BmPOdEdciANAvQs8=
X-Received: by 2002:a05:600c:a404:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-488fb73b2a3mr517652255e9.5.1777303858122; 
 Mon, 27 Apr 2026 08:30:58 -0700 (PDT)
Received: from [192.168.0.107] ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489207ebd3asm281095385e9.6.2026.04.27.08.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 08:30:57 -0700 (PDT)
Message-ID: <69ef8131.050a0220.11648d.40e6@mx.google.com>
SavedFromEmail: elisey.konstantinov@gmail.com
Date: Mon, 27 Apr 2026 18:30:56 +0300
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
Importance: normal
From: "elisey.konstantinov" <elisey.konstantinov@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: philmd@linaro.org, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--_com.samsung.android.email_348943502289780"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

----_com.samsung.android.email_348943502289780
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

WWVhaCwgdGhpcyBzb3VuZHMgd2VpcmQsIGNvdWxkIHlvdSBwbGVhc2UgdGVzdCBvbiB0aGUgb2xk
IGRpc3RyaWJ1dGlvbiwgbGlrZSBEZWJpYW4gMTI/U2VlIHRocmVlIG9mIG15IGxhdGVzdCBtZXNz
YWdlcyBpbiB0aGUgbWFpbiB0aHJlYWQgZm9yIG1vcmUgaW5mb3JtYXRpb24K

----_com.samsung.android.email_348943502289780
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPjwvaGVhZD48Ym9keSBkaXI9ImF1dG8iPjxkaXYgZGlyPSJh
dXRvIj5ZZWFoLCB0aGlzIHNvdW5kcyB3ZWlyZCwgY291bGQgeW91IHBsZWFzZSB0ZXN0IG9uIHRo
ZSBvbGQgZGlzdHJpYnV0aW9uLCBsaWtlIERlYmlhbiAxMj88L2Rpdj48ZGl2IGRpcj0iYXV0byI+
U2VlIHRocmVlIG9mIG15IGxhdGVzdCBtZXNzYWdlcyBpbiB0aGUgbWFpbiB0aHJlYWQgZm9yIG1v
cmUgaW5mb3JtYXRpb248L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2JvZHk+PC9odG1sPg==

----_com.samsung.android.email_348943502289780--


