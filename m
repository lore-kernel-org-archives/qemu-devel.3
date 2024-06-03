Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F056C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE20r-0005OT-7K; Mon, 03 Jun 2024 03:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE20q-0005OK-4s
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE20m-0003lJ-E6
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717399301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OBbvKgl4tnBsoUZUbqstLyjlWwmuFNTOAEG84Ff9rJb5hSY6DF+OUFHdU3gL5G17/fPmTV
 WBwm5peDfKzVcx9ZAXe0Vbftia/BQ1vTH5wsyBLBh+e+ff3jwGS2yjGhIkhNWmyoMEeNJl
 h8t62h3Gh1ulQ7ym4mx8iIr0YEaOFGw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-weifpwIUNgW04vIRn95L9A-1; Mon, 03 Jun 2024 03:21:39 -0400
X-MC-Unique: weifpwIUNgW04vIRn95L9A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a69a573a4so125679a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 00:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717399299; x=1718004099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=PZ9Elm5nZtk2y7ntH0obouhsYnzddDs59Y7NQ2ULziSVbCEq/tRHc9xcjKxufYb7va
 jcqUICHGMvnA/9JTm13OjO1yRwpuMN20C/f/K2C+9DduY6Mgr8EHG1FGqkZCVlEv7r78
 4zKEMiBF84HoWYXersc4V3c6/GG3GoRE9EPTYHhStIz5qCgQQOAyI9oOn0GKj3NILb41
 FdFY6lRboQJg4mkJ/vv/vnL2UCAVSMczqZlDGAIvdEusVduNNoxcXAUAfjBe5+gl/bFJ
 9JgdUZeqNgR6X52SrIMJx3i/dom5StCLldGec57LcSKLxhG6sgQjsYWwxqVgJPsVTdjd
 Eegw==
X-Gm-Message-State: AOJu0YzNGXK54psYLlJN/7knFDaI4TjqNV1Fe/fft5Rqm1baf6QvFYqI
 5XamwNDQcWHIm9tzmu8nEiVDiWYoCePN3f67uPJxPmK8dO+2wVdN3fzM9IhoU4t/Q+Mfxzxm9LN
 ArmI+OYB7YwlSBNtVRJXLer8bbdh3215HQT8p+e1XtOrp7B9oZsph
X-Received: by 2002:a50:9518:0:b0:573:555e:6d89 with SMTP id
 4fb4d7f45d1cf-57a363bfdc8mr5931802a12.1.1717399298816; 
 Mon, 03 Jun 2024 00:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZjc2TWtKCinb2Fp5SJI4eGv2exJENnhLvFn6VtC5bn/011ytTMwwH+kUbR25gZF/To83KRw==
X-Received: by 2002:a50:9518:0:b0:573:555e:6d89 with SMTP id
 4fb4d7f45d1cf-57a363bfdc8mr5931788a12.1.1717399298411; 
 Mon, 03 Jun 2024 00:21:38 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a52f5cbd3sm2589719a12.12.2024.06.03.00.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 00:21:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: lixinyu20s@ict.ac.cn
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, Xinyu Li <lixinyu@loongson.cn>
Subject: Re: [PATCH] target/i386: fix SSE and SSE2 featue check
Date: Mon,  3 Jun 2024 09:21:36 +0200
Message-ID: <20240603072136.583558-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602100904.2137939-1-lixinyu20s@ict.ac.cn>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


