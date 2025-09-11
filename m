Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2141CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkO4-0000SR-U5; Thu, 11 Sep 2025 12:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwkO2-0000S5-Ev
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:43:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwkO0-00035L-Rw
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:43:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso7358275e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757608982; x=1758213782; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f3DfDGEoQnBsJ0BZaMkF7/CVp0CNVzhtyoJr1TGIIUM=;
 b=gxPH9JC9TV3+7U2Wkj0MvxLrmgbR0cA+MzRoXMXP67vXdGEcyUMlqsnTsY8PiBLXzA
 8JEPYHDN+YrKFPn4redjjr2SgC2azQ8DYJL7z2mw4P2zWqFKtUtgDUdM0mH84fGgnwBe
 B7UzgtUGp/H6pANWey4QwkSLhAtWbdM6KRCDCvRZdIwtND+LVxEkNac1f3mpMlRc1Z6W
 uJUphpBnHajnGBiY05ZK2bq12FRfi+dsgkQe4VZWV0O0STrj5h+qzr+gQ2zE0lvJybBj
 PuQuF36nrhfCeFFJc9llHX2j2aLR2VACHzGes81R+KOZIveRB59NXXdXaoJ5GUt3NJM0
 6wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757608982; x=1758213782;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f3DfDGEoQnBsJ0BZaMkF7/CVp0CNVzhtyoJr1TGIIUM=;
 b=tXzhdc7xBx+SVplYi3STz+BFodA8k53pvmvg3VNhbFpCo3/gc8WkJsrGcUSLK9SR80
 excDeUv5+Ta2BnfuNhQ+WYnRsXwVvp5JpkufoCd7WNZb/LBRACxnTQsKCS69Vui7bYlM
 1OV5TlOPRazYUFnCzZUGkSuqSIc5tXIfPb4IvKUZ6uS2gc7dHMNUIx9UHHbK7yehrxJ3
 F77wBb+00Ou7IR7w+wTssQ64z7Hva0TBDK2MfaukNRvFVQWRxQYSX6vr7L62WTDPDVXC
 XuR39xSiAsFVWze4N0AavG9Jo96ZEZMNn4DdjQUhdnuYWqN0xCbYvfbYc5WpQ3oSp8EW
 uu+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMaABvWiBPt0WhnTPwCXzPrMN7LzmXfiHjf1Ym2PG4+GUpxIh0KH/Vr5aAjtXPf0t7/EI+KfzxdIVM@nongnu.org
X-Gm-Message-State: AOJu0YwqDXoV4MHwbURbT+RradmiHoEDg2pp5A47xEebvIstdIN0qtFC
 DC5Jc2vELgavIm5hNGUrWb46PxmdJTSrWmydsPgDG8WBN4hgvmEy0nXh
X-Gm-Gg: ASbGncullf2YhSJGITfSHaUb1xPSX19lksK2DVv1aibsXpDS3Iy5tQvf6b5Nq30GUkw
 kokj0oT8i8vokL5RmC57zJFXOVYQIG9BPO+T6ez8WSGByj4Ybh1yNKKLcmZi0yAdKYqIuQb3R0w
 GaB+r9hBusDzkYKwp8ucWc+Qzx7lrT451grh7mvYkhxy2gwyFPuMgTzzqcYo5D1yjitpLbKiHg/
 aVm5AV8Bbvm9cq5YGtnD6aJJydMhvcFwUod+YocIj+7w+LrhRz/gfgh4c2kePOATs40XhofJD3X
 VghEmyTMC+Y1UNB6pblz2xFwdyHcBqqQQyAhvOi0BJtx2RAXglRU0JE3n8wx9KRktqkvnzop/yz
 pKjQP0EoDMkfW/VAnwbIjxZjUC4ZzEXhhZu0F5kb12qKu+LKLfyN8xA9zXXnx0DTY8vzn
X-Google-Smtp-Source: AGHT+IHCa4HNmwCaQnmZ4dYzbCmnglHPVaHFbJq5Xg4VbPKl/FEP71OWMiXAfPZOgVrIYf3OB8GFZA==
X-Received: by 2002:a05:600c:45c4:b0:45d:f7f9:9822 with SMTP id
 5b1f17b1804b1-45f211ef820mr1226675e9.12.1757608981700; 
 Thu, 11 Sep 2025 09:43:01 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760786cddsm3192544f8f.14.2025.09.11.09.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 09:43:01 -0700 (PDT)
Message-ID: <a5918eaa2d28d08ff3133dccb06c1966064e5579.camel@gmail.com>
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Szymon Lukasz <noh4hss@gmail.com>, qemu-devel@nongnu.org, 
 lvivier@redhat.com, berrange@redhat.com, amit@kernel.org, mst@redhat.com, 
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Date: Thu, 11 Sep 2025 18:43:00 +0200
In-Reply-To: <7eadc2c7030c79923303a5b1b3f2bce0f27ded44.camel@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
 <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
 <aMAwL8q0i6pqcAOn@codewreck.org>
 <7eadc2c7030c79923303a5b1b3f2bce0f27ded44.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x331.google.com
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

> I will try to merge it with the current master again, which should be
> ready in a short time.

Done. You can find an updated version of the patches at
<https://gitlab.com/filip-hejsek/qemu/-/commits/console-resize>.
I haven't tested the updated version though. I will maybe do some
testing and then submit it to the mailing list for review, although if
anyone else would like to take over then feel free to do so.

