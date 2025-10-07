Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA84CCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 17:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6B5Y-0003OV-5S; Tue, 07 Oct 2025 13:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6B5W-0003Nr-DB
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 13:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6B5T-000814-MV
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 13:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759856571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=KdyYR+t20g9gn9tOmayJSeBKmgiZ5emAscSGHgDVxkN0r7ypLgtA+hkJjP7E62V/j/3tAY
 p3l75T2NSllAQfNKR0Bab+8i4jXdVSp5TpWKnPRvHOdCjH7f/OfTUPfPC7n/lgRk8g7U4P
 aYKlZwuxhP4TN3tJH6OPZqLxSlx+F8M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-6TDfX5tyOaaGpgxiQykeQw-1; Tue, 07 Oct 2025 13:02:47 -0400
X-MC-Unique: 6TDfX5tyOaaGpgxiQykeQw-1
X-Mimecast-MFC-AGG-ID: 6TDfX5tyOaaGpgxiQykeQw_1759856567
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6394a37e473so5074658a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 10:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759856566; x=1760461366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=euJ0/tys4gV7iw+TG85aw87uWExlOpr3so4wpaSOP6mKq/hTk0Zp2MZDZaT5l5CG5v
 nYBRJnE1ItfCCtO2v5qPUihXuck/m/TqqdihLYrjX0p+kGNkVGn2eBadQGFA63y1S63+
 OaubyJm9XcD7sya8PgaGPfrpLZxotL107fkYE0afNlBxFe6ZY6pZEP7bTccmLfVI6iT3
 VKPrg+8Ue4zNb1oVEvA5nahvrSm7VTEDnu6Bdur1WXbHPSrogmBAyosdwGodgatH51/f
 IXUv0hFGdu6Bdo0ti4M5rnX/xF0LEMA+XRSGw91wLjtq46QpOPoWFGkkkJIENexYl8fW
 a57g==
X-Gm-Message-State: AOJu0Ywb4tX7zFYzcFgDUn/6GlcN6nQDTRXjpgnY4Xi9bnuO1W/k3lp8
 7zyZleY+N1Yb38y40z+JVmgMcwPMDBOwHgsk12yYvk8fdU2jqGL2V9ScnHfbPvqQInFPSZWSoZX
 6LBg7nQ9TH5XSirnL9BkYCL+Amw12a8tU5xagQGbC9sWUtQRVRLTo+7Sq
X-Gm-Gg: ASbGncuSuPSvzTv1UYZRkYaZWuaS1/xReUCZSSLtLuNk+zQQ7n2jWTh7wM4k0bAhw+P
 KOOEnVul613jsrW6BGR3BOAu2imCS7iQ/7/JxBajOjErwjs0Bm/ecrNR+XKKmUbP9Wa+HNUSUli
 6GZAB5896heeTUikXGXGhl4Gdms39LLr00yKj0b0KOu08Tltjhy1IDSlTsd2hfLYOMg8g+GTsqd
 /FF37L3TRYWBs61GTPrtb0DfOkxunsNQKTFhM1WnKWRVi/5nhe238lvx8ZbZK+DNrVGucWg2cDz
 u6XJf+WEarc1e6mMDnKyhWw7dAKY2jCSI3//MuBWE6CVA1Kx7EEowsX/n0Oa2OYVgxFSmG5VuU9
 EVOhaKzhQOzs5QCR7INdor/RNEd/ImosTK/50rZ37Utgoh+iI
X-Received: by 2002:a05:6402:2708:b0:632:466d:5d10 with SMTP id
 4fb4d7f45d1cf-639d5c3ec89mr93438a12.20.1759856566625; 
 Tue, 07 Oct 2025 10:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGythAkW5iuYe7OUOLGHT5UFRdtaykrLD6A3D40MW3f1sXFS431yTNBuUs6d/ckzfxcn+Rm+w==
X-Received: by 2002:a05:6402:2708:b0:632:466d:5d10 with SMTP id
 4fb4d7f45d1cf-639d5c3ec89mr93399a12.20.1759856566213; 
 Tue, 07 Oct 2025 10:02:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63788110de2sm12839784a12.35.2025.10.07.10.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 10:02:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth7680@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/docker: make --enable-rust overridable with
 EXTRA_CONFIGURE_OPTS
Date: Tue,  7 Oct 2025 19:02:43 +0200
Message-ID: <20251007170243.307193-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007153406.421032-1-marcandre.lureau@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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


