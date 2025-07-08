Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD92C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFA6-0001qD-14; Tue, 08 Jul 2025 16:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDbv-0001UL-DH
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDbk-0003Td-Qo
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752001401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=d6pT81K2Z3czDOthATNPF2vBa+urANp/zd3PEU5rEXQgf/c4gfZxM+T6ZLC2rq5O8j6ZYv
 af5E7wd193zA8j9Vfhg4voYE9IOYHfv+gVR5kyd2pBmV8WRzftz7lmTt2UDpL64iCd/hOy
 oqUB0c2Zr9Xmj1Qx7gsrLrWs2EJp/78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-K_Qj277qO7SCQOifWR28nw-1; Tue, 08 Jul 2025 04:35:06 -0400
X-MC-Unique: K_Qj277qO7SCQOifWR28nw-1
X-Mimecast-MFC-AGG-ID: K_Qj277qO7SCQOifWR28nw_1751963705
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so22276185e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751963705; x=1752568505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=lEjNgu6WSzqh4p+lpcHT27k55vXxOatppgKXNT9lEspgaFbyp5AWAr8XiVNkftyglA
 PPFlgpoI6hX2b6n79AGlhgFHkpngHNGX8EZkZB94Qm+fsy3X9UDQMh4N79j9zWOXjfdt
 zIAHTUw1XwrsPDDrqr7Y3PfU2Ut4tARQ6BIKO4uR/ZvwMNXOLBPYjdIcqTEP9sSKG84s
 dOTl/XFKL2tUczkhviVlw5W7PLXGYfWjAlIP4a6vZKVciyfb0W4Q4Ctqiq+4SMuxBvAg
 6xmn7SKpVaBhmdFSMrIEe9FhBN362BWom4nSQoTXSR8Cv/FESLXiJmEUT5VYT4LCmVDh
 u+vg==
X-Gm-Message-State: AOJu0YwhAHWstchUon+mUBL2aa3RLYwmhn/sfnoQSsJ7e+Q4lZQhD1w9
 Tc90bolSbod03zBtKcosPQMR4OuwwpxU2fH4ym8ZJgocFIq2i9FMPApJbXdZEN92lvyuJLUA8sG
 1pf3byh6T/1eu0/vmr47/F1T9NG8z0O8O7xyT0hNsgLeroHWUViHGYeS9
X-Gm-Gg: ASbGncsZvhc4BtRC/Ve5OUxNg7Km9rXIBACkLDsb08ZP9URCR/HxjZBSPZBwCxq2cQ/
 N+bhKIQ7xJzd7R6b/lcm9ggFuB6WDVaoKWUvElsikmt4e3lJbA7HtH2tCVb5h94/MxsGjm+7kDL
 wHaY7Ib171I/DCXy+4qGjiDTwjlOQuqBIfaB+io9tDNtPBNSFJGKrdNh+O7aJ7tejgBv5S8gB4b
 m+J8TWOmlBuW4Hx7iyBAJupO0Y/Y/y4Ow0pDUUjOOCbPj11TlAwyWDqNq4Enjsi21MxERLsrEsL
 AnVAoCrj+D63OeSG53sKhhTwTJU=
X-Received: by 2002:a05:600c:8411:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-454cd4b49c8mr20051785e9.3.1751963705172; 
 Tue, 08 Jul 2025 01:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuq228yys8KKAslTF+KBC8WlfLDQa0iRUsy2Y/shqoZ1rnYNPHPQNK3PwP453nsM6GYXe3lg==
X-Received: by 2002:a05:600c:8411:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-454cd4b49c8mr20051445e9.3.1751963704719; 
 Tue, 08 Jul 2025 01:35:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd39cdcdsm15265955e9.13.2025.07.08.01.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 01:35:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] rust/bindings: allow unnecessary_transmutes (1.88)
Date: Tue,  8 Jul 2025 10:26:06 +0200
Message-ID: <20250708082606.49710-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703-rust._5Fbindings._5Fallow._5Funnecessary._5Ftransmutes-v1-1-692ca210d331@linaro.org>
References: 
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=unavailable autolearn_force=no
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


