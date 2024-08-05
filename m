Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8131C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawdp-0008Ub-RM; Mon, 05 Aug 2024 08:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawdn-0008Tr-VX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawdl-0001QG-US
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722860200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uJVYaCS8E1r66YbvqfERL10xek7EvaIj2DDHzNLltLM=;
 b=JmGa3iCxxgX+QPcJVeYwM7Ez5kmvc0Vjm8IAXgPcCEBEo3r0FRKLNdJ6AosEJvuVDJQV6Y
 MZuLr/mJC4ql1BzmxmPhvanESZZ42ir7BZWavpLR9U93AFkz3mg3w69dAEw5wLiD+o15/y
 WZlG7B0ntEsCvCmmsFLg2mNgE6JmvQs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-6xtwm33vPGOJUv0mDTHqpw-1; Mon, 05 Aug 2024 08:16:37 -0400
X-MC-Unique: 6xtwm33vPGOJUv0mDTHqpw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a822ee907so955917966b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722860195; x=1723464995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJVYaCS8E1r66YbvqfERL10xek7EvaIj2DDHzNLltLM=;
 b=IWieHSzlgsygXiKWSzNEZxqnIOhEz2eNwNdNLJKXBSwHuE5YR3qiSEltmjaFWXKYVf
 5brzENF9IQNGa6SHCZutWHtVhHW5i+FbX73Yn7LUn7ctnDP3gdSBvpCjSvmlvrJZjK+z
 CmPToeQ0TMTTk9CX2+Qlf+EsO1WtsiXeE7CaJNfODvrPx3COYB5jbK7I63P5pLqhDiku
 ZoaBVuQF17UBD0fMK+0i8ZahkokJhrUhF2UMS701R2FRO5lJLAZqXKPV0syllAbQJISd
 AN2HK7STmV0R0hzpaJZtaMTRxgA/79oq9IUc6rKUDs8pcuYcAnajXHXWI6rY5ndd9BG/
 GzIQ==
X-Gm-Message-State: AOJu0YznJbC7YNISuQabBZEIkatk2XXKsdNxXD6Kh1W/AYyYojqJNtzH
 knpquTPPq4ZgOWRyEYUn/YqibPvVgW1vKYCbNARp5Adkg2RqZd6GDFNzwr/GZxAhY9Neadw30++
 7KlPpHRVbIE/qEmSRGY6d4U7HvWcKBGHWQ/fjTmkw5JD2qSnYeVpm8cgeQx6iIoUSbqz3ofw+3s
 7CiLI/sP1WFE3wOHAAMxXtuXdfbX5PT7hOf9n0
X-Received: by 2002:a17:907:7e84:b0:a7a:8cc7:ca48 with SMTP id
 a640c23a62f3a-a7dc50a4c78mr827578366b.46.1722860194743; 
 Mon, 05 Aug 2024 05:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz2i0w6WKB2ZPXAEfthVD8s4RSuWpFbld+UjP7Ri7MkhpG7bArTkt0+8R79i41dJgmvuSApg==
X-Received: by 2002:a17:907:7e84:b0:a7a:8cc7:ca48 with SMTP id
 a640c23a62f3a-a7dc50a4c78mr827576566b.46.1722860194233; 
 Mon, 05 Aug 2024 05:16:34 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3cbesm446426866b.5.2024.08.05.05.16.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:16:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] target/i386 fixes for QEMU 9.1
Date: Mon,  5 Aug 2024 14:16:30 +0200
Message-ID: <20240805121632.482610-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit c4d242501a61093a8b80ee8f6dd071c5110a100c:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-08-02 15:53:54 +1000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ac63755b20013ec6a3d2aef4538d37dc90bc3d10:

  target/i386: Fix VSIB decode (2024-08-05 14:14:47 +0200)

----------------------------------------------------------------
* target/i386: SEV: fix incorrect property name
* target/i386: tcg: fix VSIB decode with XMM/YMM{4,12}

----------------------------------------------------------------
Paolo Bonzini (1):
      target/i386: SEV: fix mismatch in vcek-disabled property name

Richard Henderson (1):
      target/i386: Fix VSIB decode

 target/i386/sev.c                |  2 +-
 target/i386/tcg/translate.c      | 20 ++++++++++----------
 target/i386/tcg/decode-new.c.inc |  3 ++-
 3 files changed, 13 insertions(+), 12 deletions(-)
-- 
2.45.2


