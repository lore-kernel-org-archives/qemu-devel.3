Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE0BC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2v4J-0001b0-Ln; Thu, 10 Apr 2025 12:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2v4G-0001RL-0O; Thu, 10 Apr 2025 12:47:56 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2v4E-0000de-HQ; Thu, 10 Apr 2025 12:47:55 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso748191a91.2; 
 Thu, 10 Apr 2025 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744303672; x=1744908472; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Si6z4SPJRpKpJ3XC/jBZK8XllF1BVz1y8DYFrGeTSbg=;
 b=LDYmEG+2Nznvczaakzj/5S+8K+l6sj62rAypslc5XL0HLTrllWWoSpA5JFOcClxHuR
 omcd1j7E3tXm0b8UPz17uEo3UMb4p+28WU2Ba1PAuBeGAu26Unz1aOmomwk+rdFmYWyH
 imJK5jxRppIyN1IgBzaekI5HyZo4GgdpK4F9vMHYal3YynJaQ+SO7+xY1Vy3wvK+K74q
 d4IR7TaNd6fhMPfhNj5CarUNn4frBi4rr0R42KWpe/12QelfFcb8BAXkxQhKanuUgmYG
 vIuohp70kY3lA9+2Lz2dybjGB5Zwqpmigq12p3zYnrXsC526LxaToU5POx/AqUIYVD3M
 XgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744303672; x=1744908472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Si6z4SPJRpKpJ3XC/jBZK8XllF1BVz1y8DYFrGeTSbg=;
 b=iNkShCjgv7cw/yFt44dJTt8M26xSNqf8C+9NqE9ZooOq7cKkjTjywRn7nFY8Bs8zlM
 pVO+tca93DteJdJ2d5ZuXvQjHk645cUnjPWlkoL/izDCoqKgSd9lgBxavAMkFEa3RxhB
 ZwI3KHtUy0Y4XOc32Prsw0QIUwLNJ06xPfvjbWvgJ/S370SH5F5LfGj20bStbGLs0JNv
 rN5LUA67wKOwkF+Xt7cqPRTUAIHxKCG5qpZ7MNkZSryPYTzLZ6I1trqD9TPkVfs21Anx
 vnEgX/vTGMkyfncb0JSABx30dNHgcSeWmPsEtnC8zb24+Z36kq+Y2E3WLvBLZnAwWxxx
 Xfrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHS4iLRc6g5iWjBr61e+ROQwZijVC4BvSbKKm+8+p1+quebGkyWjsN3Wuc5YI09zW/M+MI9hwCTJRw@nongnu.org
X-Gm-Message-State: AOJu0Yxfc6CB+RR6ome/2POrffwgCdzI4kNKYAYJ6BQYJAAi+zaT7nbn
 25MMop0AYWY93vO/CPfA1vlwNqhjcFIlAVH1bRuY/3mFcJEpVwJgVAW6p3XDUhlZUyXjI1PT/3J
 H8K10/1O97urFEENWbMDOvcjxkML6LA/b7jQ=
X-Gm-Gg: ASbGncvKBvnvc/7vliGTZrGG+18Zfq5UH1HB0AP8juusNoQ2nEnLdr3C+Fm3dvPTXFM
 xOIgteJ6MkVSv0EmKnQfriXbkri3XIRwhXhoj4kgpcRvqMnbhiGAenXFig9RJZyULQbVU8HtX4L
 rtk8rTxfWE321xc9gglBB9rWBMbyC58rJXs82DThxHHNselDsNaEM=
X-Google-Smtp-Source: AGHT+IHqAZ3EGz3VuhUramcVMY61Sa/QZkz4k+gdiJZC+Ryim7ikiEYFEHLrT44xnM4B6uAI9OIsqegH3Dzt7WKbpe0=
X-Received: by 2002:a17:90b:582b:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-3072ba2262cmr4228779a91.32.1744303672072; Thu, 10 Apr 2025
 09:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250410161722.595634-1-pbonzini@redhat.com>
In-Reply-To: <20250410161722.595634-1-pbonzini@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 01:47:39 +0900
X-Gm-Features: ATxdqUHsflm2OM-on5kmrxQAiAlKpYp4sNYJThRuP8t_gLGCsDmxDDFftQVT51I
Message-ID: <CAEDrbUaMaGT-=M7qhQQqakzpGD57csZcs+xOjyAB-O9pY=v9gA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Fix type conflict of GLib function pointers
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c1213e06326f58bb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102c.google.com
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

--000000000000c1213e06326f58bb
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,
I appreciate you addressing this issue and submitting the fix.

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--000000000000c1213e06326f58bb
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Hi Paolo,</div>I appreciate you addressing this issue and submitting the fix.<br><br>Reviewed-by: Kohei Tokunaga &lt;<a href="mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;</div>

--000000000000c1213e06326f58bb--

