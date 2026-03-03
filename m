Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A4EC1422
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMzz-0007WZ-Vh; Tue, 03 Mar 2026 05:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1vxMzx-0007WM-1M
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1vxMzv-0000Vt-BY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772533741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=UZT2Zi4rNe4G2q5VBUh4QHVadiahBqdwCXlQqn6JETM=;
 b=K6fZVL4XaFAJkLOqe5rWZN5BtdwSj7zs/mjfW7oBq6Ju0/IyL6t4ZuLgtenziY5TFS8SUT
 mnOlUmerLBjyb5+E9od8yPLIhtpHRLFQdlu3Xc6eQg4tuOVvyQCOHoRDAmNfZXZRQt4dSP
 h9nRGksRI58jAlDaLFJqriMGXgwtkxQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-9-Z1WQUXOhyXAmPTOeFQ3A-1; Tue, 03 Mar 2026 05:27:48 -0500
X-MC-Unique: 9-Z1WQUXOhyXAmPTOeFQ3A-1
X-Mimecast-MFC-AGG-ID: 9-Z1WQUXOhyXAmPTOeFQ3A_1772533668
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7986dd1b9e1so101455337b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:27:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772533668; cv=none;
 d=google.com; s=arc-20240605;
 b=FrRdPBc6tXRZnIvAMLQz0v6VHqO1db0xcBP4vGOa+Xkxh5bV7UkvVnZ4eMB5zp+Syx
 GlfsN77plVQHMjriz/Az0CvFSF4IfFJCIwDyzHCCVDeIRAvrVb9Kj26DB/zbl6MrY6iC
 fParmTpexV6pNzPL8LGsQcqVqvwLRNORGRVdPMYfoyRD7Kz11C808cN8JMA4FCUHbp/n
 pqcTaKZQP7DzEszlSpSF7Xa9cgWhDQRlrmXncgqvcwITl3zNCI1t5zwvMGcMUAG4U8ZE
 9cxDbV0DgEH4UwgD0+pLUTs8/rohUvuUWNM5ZzqbNWkLmAsVmHOjJqpCg/LESmsDlBCP
 klXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=UZT2Zi4rNe4G2q5VBUh4QHVadiahBqdwCXlQqn6JETM=;
 fh=M+PQ/mPxrlNcwBcpzJhQbIZh5naQ1mTAie8kXWVAj2k=;
 b=E7AUlSl8ExHuScDnKE1LXPO2nlvtjCNNNrGbuXFf13tJIjH1mtSyq73JPBm2bh2r5I
 ia5yNYWXv8Xa+Z8C2jwBOccclp42oovL1CLX4F3K6Iq5UTm/UT7fqaNaKpazn78uf9v3
 QgViRFX4qwxLyUnxkyIhA9L3s8sc1LZjg4P51hwcaAQU2HDSPsWSP6gRPkd6xL2fvzI0
 dAZKEGGtJGkzIk2RkVmVh7ss51frTU3fCfDptM7RCdkUoqufWmTgUEgJ3boRoBWPn5xe
 2QAj82wdwld5TU+07KpttZP6zlRLUMcPKhSWV0TUyiv9YKHzZolxCyEBZrT3KAAkkT+r
 frCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772533668; x=1773138468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UZT2Zi4rNe4G2q5VBUh4QHVadiahBqdwCXlQqn6JETM=;
 b=GGmSxMbSbs8I4P2+kTvWBoqCVrQrK2T+itaVI9YnFhZZqMbJlMEJhzGoTVFJmpzMm5
 2wPZsGzjYrrbNi8gvO+QOE2WE21d51PnYKjHKTUWVMJmfxrt0d2SqOiP7zWhm2e5bnex
 6TufACDsLhy0c1Ro+9c6jx0SCrevEfHhJmdWmi5797MhCcOyrQ3dtxegcX8dEB+DdTyJ
 6mo2xoEB5pjAeOofxNDTW2x0qLqllQ6cp3jnxkzH8/aGf/sbm/CeKnDWoE/+6E3ca6fr
 W7bIHZfUKoY5K7seLXr8zB6qscYWKwoseSOZg5Zv97PDYcQvgGmrQbiolOIuozV1zRMa
 7AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772533668; x=1773138468;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UZT2Zi4rNe4G2q5VBUh4QHVadiahBqdwCXlQqn6JETM=;
 b=ChhI2FfHSdKhRhAcFW+Wwpa73BFcFhKBkvQBewFAN9UzkrpwT5YjfmNZCt/tLZTQs2
 9rJA/4YfTx0nG8OIufLZ6ouTaHt9tNzXrWoQeoo630B5a71GTPU0HXDA7AtjXaDGk1nD
 If1WVQoEijWqI6Lj0fjH7/9vJ7okcg6ZaQJYmobtYd2VJ3SxCCLbXECwQZfj+Ubo71BB
 SNCL0J8EWRFkaExwEPbvx7JQj6H7xrz6aa4SClIo00dLRb7SYhRAyk7q9Q8PT/rV0jsD
 8IfaPfd1VR8qkRy+RvZOdpMkaH6vTRXNTctnx76ZesA7gp02H8SNKI7grokixgzMvmXg
 2Knw==
X-Gm-Message-State: AOJu0YzkytNk2CujtV/bQkA6PB8DUv92bgVoTGJCsy9lAeOaSytPobIm
 Uc49+9OTy6yrRKYE5vqd4DQZsDMegiaI2E/cs4Ig+W/FDuhOjGB83jyQksOe1MOqYkrMeauxQ5C
 RHUiGJZLZGkHZbhi3YdGTP6fdJ1QiKDcNvbvZ/dUtDAo/cMG6oVwbG3o0he9pLvwuYPc5xKc8DY
 1URLC+t8EgpPHAqC7beTQm7SB1awFQrsMC4CR/KQ1W4A==
X-Gm-Gg: ATEYQzxqY3iHV7vPT0W95HP8gBE2ujN5LmTbz7DEBeBlzX9UxHAe5LATIsqh7meAKLX
 S5njjHrub0g4nebS7Rj8lDFbUjCnDPP7aICTzWfGqcMFhDhyrhTVnolS9gHL0Itt0wJiIKs+Gua
 njUjy8e+f+Q9yG8flaNl2StWgvyqlp21FvieU6Jx1tR2OGMKnQDpd3lMBqkF+Pj0q4z+9hIrPXU
 O1tMLM=
X-Received: by 2002:a05:690e:20c3:b0:64a:d444:48f5 with SMTP id
 956f58d0204a3-64cc22c649cmr9894441d50.65.1772533667980; 
 Tue, 03 Mar 2026 02:27:47 -0800 (PST)
X-Received: by 2002:a05:690e:20c3:b0:64a:d444:48f5 with SMTP id
 956f58d0204a3-64cc22c649cmr9894434d50.65.1772533667674; Tue, 03 Mar 2026
 02:27:47 -0800 (PST)
MIME-Version: 1.0
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 3 Mar 2026 11:27:36 +0100
X-Gm-Features: AaiRm515MmO4KUkZZP0vUj89wvoH7cRb6GnsJ5XH4fDHCvhYrfcjCla5rGphNvM
Message-ID: <CANo9s6=YV6Cyyn7m5LaGaD7U9i61OSZwMyiyLbmUk_xHO4s8vA@mail.gmail.com>
Subject: Meson build fails with igvm enabled
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lleonard@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi all,

I found a problem when trying to build QEMU with igvm enabled:
When igvm is not installed in a "canonical" path, the build system
cannot find the library.

To reproduce:

build igvm (latest upstream, as there were some problems with pkg-config).
PREFIX=$HOME/igvminst make -f igvm_c/Makefile install

This would result in igvm being installed in $HOME/igvminst

Then build QEMU
PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$HOME/igvminst/lib64/pkgconfig/"
./configure --target-list=x86_64-softmmu --enable-igvm

ninja -C build

This fails with the following error:

In file included from ../stubs/igvm.c:15:
/root/qemu/include/system/igvm-internal.h:19:10: fatal error:
igvm/igvm.h: No such file or directory
   19 | #include <igvm/igvm.h>
      |          ^~~~~~~~~~~~~

IIUC the problem is that the stubs/igvm.c file uses the igvm header
via the "igvm-internal.h", but the library is not added as a
dependency in the meson config file.

I tried this change to meson, but it doesn't seem to work.

Not sure how to fix this.

Thanks,
Luigi

index 6ae478b..5ac4ae9 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -72,7 +72,8 @@ if have_system
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
   if igvm.found()
-    stub_ss.add(files('igvm.c'))
+    stub_ss.add(igvm)
+    stub_ss.add(files('igvm.c'), igvm)
   endif
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('target-get-monitor-def.c'))
diff --git a/target/i386/meson.build b/target/i386/meson.build
index d385eaf..b20e2d6 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -27,7 +27,8 @@ i386_system_ss.add(files(
 i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'),
                                        if_false: files('sev-system-stub.c'))
 if igvm.found()
-  i386_system_ss.add(files('igvm.c'))
+  i386_system_ss.add(igvm)
+  i386_system_ss.add(files('igvm.c'), igvm)
 endif

 i386_user_ss = ss.source_set()


