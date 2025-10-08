Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B79CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Nkj-0004Fi-35; Wed, 08 Oct 2025 02:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6Nki-0004Fa-4d
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6Nkg-0004Al-HZ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Nx9VbYQTVKs/xrJrZnY2Kzme7sO/b3gcnj7oXTVN8uf/QV6cvyCRWiCLQSAay3dgf7sOhe
 FXpVLQtlxt8ppWssOLA3oRkWQs+R+WgBLs8vhh2KPJbP8SYCNCUG3kWJ4htzhz3REA40TX
 XHw83MQZ3dXNVDY1wPSXbbDXRb+lhyY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-DCpOAdGYOdadcwcbsOQioA-1; Wed, 08 Oct 2025 02:34:15 -0400
X-MC-Unique: DCpOAdGYOdadcwcbsOQioA-1
X-Mimecast-MFC-AGG-ID: DCpOAdGYOdadcwcbsOQioA_1759905254
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6215a926e31so6255378a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759905254; x=1760510054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AYGbcCmwngcJJocAZ2eZBU+U6nO1IN8Skl3ccT4crOjW3IOqeaFn1e0zwsmRljDHlU
 luTytzlfm/dsMJNambq7Rg3oqt/ws3j3CxlOwU9D4GtfQEHHPqJc6utD/kjKy1VLyVL7
 vGBxMLHKJT42uLjslLTf0IwRo+VQjYKTeR9YoLDpUIjwLe6cQeepPdMU+qy4JY8dPdie
 ee5zg2ZNnyFS0IjEmb5XmfCFomf7ALqcndohFxD4RibFdD5zmcYCRYq9n8hApRi2i+LS
 05yoyWlvfr1jMLAu9+lxPQZbA6tjl9olenMLH246NQEuGrn9LkE1bI+FT/zDwS4rKEeq
 r5iQ==
X-Gm-Message-State: AOJu0YyOxz9J3BItcs94FKCDA4nHTHDFAykzyA8YtTBwJiPT9wSzUrm8
 PHUvWdfMrl44YObUZ+pJc2dSBp9l9xilyBKKKuHedzRXoU6nHLZKQxhnhrIYkHWxKpdRuh2ULSD
 OIbJpmkY1wG3GgImOMHG1CNM+JV9gQX0qlHUk3UxfWTxPeNiK0tQaptUlS7E0GHMy
X-Gm-Gg: ASbGncsrBNzH9XsKhKkYcqwE4xa9mfOch/gmf9dakEkVNQKRCuVjPjBQ2mXNYFKqdip
 SerkjuE6BFDI/R6G4BMHlfq1Md7ek6nvFPpo3jCmlVKOX+KfDXLkmwpA7t+AQ/mfhDDcRGIj2BN
 Qp3ZL30MFpjOx61RNYGvpV/Zrwr7V0/Ro2q6+dBDfGty1k/B2Y2ErLFS/oVB1ZSymCCrnzJKzjF
 BBImrfCUyxN3w9r1//sABwCy/R7fSan3VSdeRB5GhVDFvMIH3WL4LTWYSRj2iAuS+9VgE99kVHR
 COycD2QD0hXx/ArniLHcmzezOwuKvGfDpY3cn08vmljLBVskmR1kQoZbnwAej9FPo9+r1vV5OBH
 fsa53gOgZdjCegxOE3mSHodQ0PC4N4EJcsb8KKDEtZ5aCkqKl
X-Received: by 2002:aa7:d0d4:0:b0:61c:8efa:9c24 with SMTP id
 4fb4d7f45d1cf-639d5c6fdf6mr1416814a12.37.1759905253951; 
 Tue, 07 Oct 2025 23:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXjSS1c16EIUbU3HLAo0b49V712Sh66tooPOS+NEFjHedIHqFkdXGxEVh/xeeSEFvTOc+xQ==
X-Received: by 2002:aa7:d0d4:0:b0:61c:8efa:9c24 with SMTP id
 4fb4d7f45d1cf-639d5c6fdf6mr1416803a12.37.1759905253571; 
 Tue, 07 Oct 2025 23:34:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63788110224sm13860261a12.39.2025.10.07.23.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 23:34:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] rust: fix path to rust_root_crate.sh
Date: Wed,  8 Oct 2025 08:34:08 +0200
Message-ID: <20251008063408.376247-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007194427.118871-1-stefanha@redhat.com>
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


