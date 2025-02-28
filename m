Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6B2C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxZz-0001It-EN; Fri, 28 Feb 2025 05:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxZv-0001IT-Rs
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:26:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxZt-0002o7-Nz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMx79k1F/HwkzQuVSb6GoWkqmWoX7Eq0E8NNjxHcFj4=;
 b=eRY2EPHOyNaNxh483IJg2USzo13hKQpqJsQuDwHJSUbnunKTlbTIN28sB7buMsNMaj3Om9
 d0j7uz9DV/P5983It6+lFOWlXrQRrdYO0dZeqwXELda7w7MvrR8CGFePiDMlF9iF6VXNMV
 m1Fuyh3ng/uJy++DdWxeE8MGXTkcxBs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Kl0_2kasOVGGyCfcnnik1w-1; Fri, 28 Feb 2025 05:26:39 -0500
X-MC-Unique: Kl0_2kasOVGGyCfcnnik1w-1
X-Mimecast-MFC-AGG-ID: Kl0_2kasOVGGyCfcnnik1w_1740738399
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390f3652842so131748f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738398; x=1741343198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMx79k1F/HwkzQuVSb6GoWkqmWoX7Eq0E8NNjxHcFj4=;
 b=V/h1Jwp+66vgoN6BsFAJe+Gh1PmVBXTXA/BZyaY/58xvNt37ytYo+5mV9TLNvzFEju
 wCaKsdDhSaNhGg9pCJtL52IDRtlcgLTtk/rTWNUInrry8YoSJh4r9gFxuGxOapGjqtiL
 F2p2XEZxX+L/qrFwhcYdgBNo9p1dDuD2RhlTrhdr1asMtimNZSVhGWok4zFmXN4EreLm
 xxncrEToIoKWtpH7i4SuELReSOcauPfecn//8Uvs6zWYDqllK4jEd48O9ixbgI4ZPc3U
 lYA/nXPfllyUUq4dKCJpN9Tu1bw3ztQ3YdpulQTiyky/HCxW2H5VWHosGOuA3xonDXRx
 lvCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhrClzvFbXtjQvRvPl5MyTMCPOVMxpYAl5R3BNp8fYBw9BjkspdWCtorKacZ08bvrMeN+4MenqFCCR@nongnu.org
X-Gm-Message-State: AOJu0YzuvGutYuFrqYUmuiPRoTY9QQhe/KraMthtcR4eSo0oiEqTEcfj
 wSyLKIxcFis/95aM9ZlpZvm6a/C3hHEaaBD5XUvB6CT/eKNBJHCUj68Lgp+bgkrhr3Hxep/aO4X
 vJrBekogt/m6RZgmNqRbilKKAjQmpEaMuSe9IQMSc3kZ+WsxMK3BL
X-Gm-Gg: ASbGncsEMjFlSZyw4VRYQIsMjRPeSoiSHjGuWJcJI3rBypJRseMqlWRx06bwaf+YFWB
 JrPLmf2kBitI4SS/8dCsD/wLzHZ5Sy2yRUxiDEs+mdsXE9TlvLJaMuLAobWsyt1+sttqcs6UMFn
 Hn0VbVsj91oF+8XoFLLaNq9dM7F5ur6pkuZhBIgd3FJOTNBtH9mYkBovtoXoA1BCEExbX03+g9r
 HcrN6PAIsB2cXx+gSkfAkAhsCyRLPXupSPJmzE6kZ0OpN8Gvs2ZEIMSU6+ji8INwApwI/aXHN+7
 Ll7dU8pGKdYtCLpgPdVd
X-Received: by 2002:a5d:5f93:0:b0:38f:23f4:2d7a with SMTP id
 ffacd0b85a97d-390eca070a7mr2351412f8f.40.1740738398569; 
 Fri, 28 Feb 2025 02:26:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUFgCZeQyDjik7DU25nQoGZav2Ak7HF7/wlS4i8RkgLJPvM+lNVRf0nycjfS8wQxBV0JJqsA==
X-Received: by 2002:a5d:5f93:0:b0:38f:23f4:2d7a with SMTP id
 ffacd0b85a97d-390eca070a7mr2351399f8f.40.1740738398265; 
 Fri, 28 Feb 2025 02:26:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a72d5sm4862523f8f.31.2025.02.28.02.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:26:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Patrick Venture <venture@google.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, qemu-devel@nongnu.org,
 Nabih Estefan <nabihestefan@google.com>
Subject: Re: [PATCH] scripts: dump stdin on meson-buildoptions error
Date: Fri, 28 Feb 2025 11:26:12 +0100
Message-ID: <20250228102611.867231-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227180454.2006757-1-venture@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Dump sys.stdin when it errors on meson-buildoptions.py, letting us debug
> the build errors instead of just saying "Couldn't parse"

Sure, why not. :)  Queued the patch, it should go into 10.0.

Paolo


