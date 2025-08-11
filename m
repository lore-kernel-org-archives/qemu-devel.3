Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171BACA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVDi-00046r-Jd; Mon, 11 Aug 2025 12:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulVDg-00045q-Lf
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulVDa-00011z-9c
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754929065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N1iixlpvzFigr3G7v1wnAjQ5V3Icot6W1f7E+nXTxic=;
 b=c0zKBhYk9muKGGRwhBZHIigw5DSl5LWHkx4jMJqscs7kIFZqiR0q7O+QwDog4t4kZ0QebP
 +liH0dRW2fWs3nnktipqoKyp+x9JCyhJPoDhUyABOV1XCCfTngBQ11guQmeCWD5ODqH+w/
 t6RD56I8ql9jckfXATRvpx7IFVawQwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-94qiXIcEOTef-ycDiNKCkA-1; Mon, 11 Aug 2025 12:17:44 -0400
X-MC-Unique: 94qiXIcEOTef-ycDiNKCkA-1
X-Mimecast-MFC-AGG-ID: 94qiXIcEOTef-ycDiNKCkA_1754929063
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-459e6c564fdso18870105e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929061; x=1755533861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1iixlpvzFigr3G7v1wnAjQ5V3Icot6W1f7E+nXTxic=;
 b=Xi7zmQaWekyyK+ElJMRdvS6+LnNfOCwyl63UVcH72TDGohgmrVcBrY0EQGqeSsZjEH
 fdiYP/15R2M+hU3UKBPKFMkmjySjnDg6UxuIjQ7K01GodEEgM8adrOvwu7OyaHkphuov
 Ta2wDH55wpZ/KUXLf+qjrqfm8ucD4Xa91xgM9B3J5TPoCsplqbwOwKo99csGj5BGxTzP
 IanlggNNNP5hKMBj3Xsuin1yLQA+3BwNGa7zBwniXZvUd2UFfJ1DtMksP81n25AaJVhO
 w6N5PKqM81rA4I4Pfn+Lmob4JOkZBL+TJAiQVDhzE2rWYovjAPNMAvovjvUe1JfR/UmC
 m8jw==
X-Gm-Message-State: AOJu0YxCzq5GTugogMLI/NCGgaHGvGdR/FWUuFy98JdERRUkgIa0YrMh
 3/8Gb92YxpijHRf3UbkR659A+BTBIPGpdv05b9PDMjQES8eMugoo8mXpQv9tlae7WYgiNRVsIrO
 rlTlN2uAHd2V4HF4rEfRwt6QpiS1M4cmgt0vFXtadmAfjmqGqpgAxClKSaQzFop+loJpR4pd0vc
 +r1BD06aZ3j0hJpToisPa/irWEadIHqugvDR+n7WyE
X-Gm-Gg: ASbGncuaWZs7uyftFcTxNVOLZdyZy6ewGZBqipRaY+jhKO6ZkjIB4p6JlMtTVlPgW7X
 MzTn89RYgKpQzG1AjGVJJhh50QN7D+nIsykMHeF8MyYhhiga6RE5U0MkBEAn5a0CjzRvssLgxMC
 ZvXDB9KYtdfsVskaI7HsDQlt/wSZgPkXIoxA1bt6y/0jygV0h9zSdBaaoG3lJw46E5mLEBOfZ+t
 YV0h9L5XVGWFYkqCBfe4BB/sXVpr2lq8DIamPhlIZeTRpj3z5BcZE0e8mGDcH+Qyy3oY1BbfkMk
 38BQ8jg+bJfxbdFdrz+T1ANOfc8mSrcA4rg7yssdTLkH
X-Received: by 2002:a05:600c:354b:b0:459:d9a2:e920 with SMTP id
 5b1f17b1804b1-45a10b9ae16mr3256675e9.4.1754929061475; 
 Mon, 11 Aug 2025 09:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtXbuAIEQnWXh49iGPKRgyGYh0nd7HBdOb8u1ecMrcFAlXo5Is9Q4paztqRCBd9L3uKMv2jw==
X-Received: by 2002:a05:600c:354b:b0:459:d9a2:e920 with SMTP id
 5b1f17b1804b1-45a10b9ae16mr3256335e9.4.1754929060989; 
 Mon, 11 Aug 2025 09:17:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm40907795f8f.15.2025.08.11.09.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:17:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [PATCH for-10.2 0/2] meson: let Meson handle mixed-language linking
 of Rust and C objects
Date: Mon, 11 Aug 2025 18:17:35 +0200
Message-ID: <20250811161737.220835-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

One of the pending issues with Rust's build system integration is
the bloated executables caused by the use of staticlibs.

For an example of what this means, see the following test:

hello.c:
    extern void hello(void);
    int main(void)
    {
        hello();
    }

hello.rs:
    #![no_main]

    #[no_mangle]
    extern "C" fn hello() {
        println!("hello world");
    }

staticlib + gcc:
    $ rustc -Copt-level=2 --crate-type=staticlib hello.rs --emit link=libhello.a
    $ gcc hello.c -lhello -O2
    $ size ./a.out
       text     data    bss     dec     hex filename
     917435    39593    352  957380   e9bc4 ./a.out

rustc + static libstd:
    $ gcc -c -o hello.o hello.c -O2
    $ rustc hello.rs -Clink-arg=hello.o
    $ size ./hello
       text     data    bss     dec     hex filename
     322684    14464    590  337738   5274a ./hello

rustc + dynamic libstd:
    $ gcc -c -o hello.o hello.c -O2
    $ rustc hello.rs -Clink-arg=-Wl,-R$(rustc --print target-libdir) -Clink-arg=hello.o -Cprefer-dynamic
    $ size ./hello
       text    data     bss     dec     hex filename
       1809     600     993    3402     d4a ./hello

The second and third methods will be supported by Meson 1.9.0
(https://mesonbuild.com/Release-notes-for-1-9-0.html).  Modify the final
link pass to use a Rust source file directly, instead of going through
a staticlib, when the target includes Rust crates; Meson will then do
the right thing automatically.

Paolo


Paolo Bonzini (2):
  rust: do not link C libraries into Rust rlibs
  meson: let Meson handle mixed-language linking of Rust and C objects

 meson.build                     | 19 ++++++++-----------
 rust/hw/char/pl011/meson.build  |  2 +-
 rust/hw/timer/hpet/meson.build  |  2 +-
 rust/meson.build                |  2 --
 rust/qemu-api/meson.build       | 15 +++++++++------
 scripts/rust/rust_root_crate.sh |  1 +
 6 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.50.1


