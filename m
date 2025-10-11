Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B230FCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 07:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Tzv-0000uu-Ja; Sat, 11 Oct 2025 03:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Tzs-0000uf-RG
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Tzp-00051h-JI
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760167587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SgjB14FyG9rMQNWZThYcH688Q7YZKI86O5LlYmWGUvlznWtpsJqM/xMDcFHjxPuf/k4Th4
 Zw1evsnlxFqXFaiswxODAR5+pZtU0KQHlENRwTz0ZmWhb8w8Rwcmeg1e8GaUq7xUWW5hDu
 EETD/KZycrTvaRQVFykqyOzuvfXortU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-yzluabHoOWydrmkzbm01Mg-1; Sat, 11 Oct 2025 03:26:25 -0400
X-MC-Unique: yzluabHoOWydrmkzbm01Mg-1
X-Mimecast-MFC-AGG-ID: yzluabHoOWydrmkzbm01Mg_1760167585
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-63468fe211aso3000822a12.2
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 00:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760167584; x=1760772384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=F3B0cWPepk2px9suuytA/RrBMNWtDTazlkIcsdzt4nORKSpb8eqtUokd4YOaCn0MQP
 itd2ztYfQVQCND/8X34JmbVa50sBPVyfezL5FX224G+qzjokJVN/G3gHboPVjiQaO2o5
 qu/8QidK6mkZhbE9bRqWs4Cn1lkOvBR9pf8SMoxx77WVCaORXV5p0dFgc8ywPli5KDkD
 5lGw3DdyizV+ewxQkZNZV+maurG4s9GTlfzZPrDuaFmfXYBhMTnX9aePIH0b+DlNWwrq
 2iXHL+0dGt+rKKklyw8RDuelPRS4uzRSler6doe9tpOsIQvG052vHikFryQArF0wKxxq
 4fbQ==
X-Gm-Message-State: AOJu0YwNLVEOHm3pbRcYet1GtfDHS/xS5FcBDxFcbDpPNdHtkdJ872ph
 5xqJQ7M1alnuJ2V3n/HRTAEJpP98k978x7jtuQw2vWRaYj4szArjIBQ4V/QtEqH/NhHuxu+0IYG
 LiSk7ODGvKgTv3yjBPOiyazqvsv++o7N4OglY/SVrq4PZYCMkuVOp8K1GmkBkl7Dw
X-Gm-Gg: ASbGncvuKqXZhsTFnjenWpduwhjwu3mZoo4+UHyKLDIFjdMvQyysGxboKncLvlgyaA9
 EG8jzWwEusC1+yTu5JHD0HZdmiPpz1PwZhcK2vGymieEesN2R3/XIejJ1TimTtKs853nJieshKv
 s5zsnUkpugoKwAGERU/4wFU5uW4jg1fE0lf/Nku8/5f4WoVxxoWO4UN6aoDraFdkh3yFjpw5urp
 mMQTrVfkD7vQgPQGgpYg0Igr9MgVedGk5OwBaqHJ79mMTWNOSSsVNNy+bzFP0WdkwkhahaMJ3c3
 0zfo178JlniVdRunvKgFx9+qH8NcnzFlMsI0TXNFfnVV4YhaMZGTG9vLUg0gRB+yk9bOT821n/k
 8HqdsEm77GoT2PHCXg5SVFEonqu2nfEKaPM8McSSDgzw6
X-Received: by 2002:a05:6402:50c7:b0:62f:5424:7371 with SMTP id
 4fb4d7f45d1cf-639d5b417e9mr13531416a12.8.1760167584072; 
 Sat, 11 Oct 2025 00:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBMZafEGLjWYwTPIaEEmYP6ZNVZH0wBOnyLqjx5ludrP19PLhSFtsdzsRUWRwuY7JGjqnsQg==
X-Received: by 2002:a05:6402:50c7:b0:62f:5424:7371 with SMTP id
 4fb4d7f45d1cf-639d5b417e9mr13531401a12.8.1760167583713; 
 Sat, 11 Oct 2025 00:26:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321341sm4126811a12.38.2025.10.11.00.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 00:26:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Ogrisegg <tom-bugs-qemu@fnord.at>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] target/i386: fix x86_64 pushw op
Date: Sat, 11 Oct 2025 09:26:20 +0200
Message-ID: <20251011072620.872068-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250715210307.GA1115@x1.fnord.at>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


