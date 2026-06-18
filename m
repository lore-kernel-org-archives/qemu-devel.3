Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FA6CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEhk-0006LK-NY; Thu, 18 Jun 2026 11:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waEhW-0006Jw-M8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waEhU-00087G-8a
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61hWwuBh5pCtH87sGeavuORS8Xg60T66frUqAc+ByEw=;
 b=DhOHfL3TxspLYQKjrTmEsPMToYs5A7/bsKtap0g8VDgD1w4UgvC2KXKwo9IGz1Y5mleLrp
 EqZTncgQGzCAX3z85I8QSIy1kXUYx8hVNE6kl7PascnFXsTBjBisAppaTAN63+8f1qDkTa
 XV+1K01rs/lihHhQNQ2aXF5Z/8PgW04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-9IoTblpmNC-xZLvcKrUAZg-1; Thu, 18 Jun 2026 11:30:37 -0400
X-MC-Unique: 9IoTblpmNC-xZLvcKrUAZg-1
X-Mimecast-MFC-AGG-ID: 9IoTblpmNC-xZLvcKrUAZg_1781796636
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-460153ce644so732468f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781796636; x=1782401436; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=61hWwuBh5pCtH87sGeavuORS8Xg60T66frUqAc+ByEw=;
 b=GZuP3FT+m60EROjOAC92NY3n6eCFdfUrJ7cKZjO+lypCuU6ZU6V04svFAPYUqoP1pN
 qc8GnKcc++xNDs+OUq/JVZpv8y8bXOaUxbJOkVuFyLCsANhP6q3S6O+uuOKt/CEcsbKx
 SLo443aezCGGNLrGA2YJQYXk85hp7WI9fO5hkt7dPKBzm7V4DXnxpoQZwUGdMcVMP5j2
 WiKo3BMtn9Gq72w9gdgYvSf+8g1Os05Luj824gHo6xhywlLwJesOEZYzNLLzhTnTog2U
 rs34ywW4bRdj7WsrfH3fPfI+n8p8XHD56wTcLM3BNO6vGxW8WNDvSPp1WiYGkCVXjp4Y
 MD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796636; x=1782401436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61hWwuBh5pCtH87sGeavuORS8Xg60T66frUqAc+ByEw=;
 b=GJ5xt5u748OyGeCcDvempoWRqYpoOQSjx3QRfNS5cCpT0R7YNUMJEdsl6/DQnZqmdA
 v+ZdhWsrGx1BBdwG5QJuoDD6jTUNwz28sv/JGrGD5BKkVpnECtQGA7t42qPYLya2wbqZ
 AnGgxrmn/shuljVAZON7eYIw00cKpcJt1usyAvwJRZlDUg8jg6c7E82fv+uHu9+XC9FX
 byWxDfXnzomoij/udfW9ogdYwqxajRdV6juig0EqA5lu0KWBbN13wRDJwdbCkkXrkIqR
 895kzF9AZbLZ3oHIQ/ScyT6MOsllpAmrclbslomxrSXn1LN94EhnHZPkZb2qVZIwmbri
 2mig==
X-Gm-Message-State: AOJu0Yym0zS0Szf3fTWDg10cudaicmPgjFlmbCKJidB9qtFCOC3UsQLN
 TYcnSeW3Kv+K+31InO5v0sZXh6tWO0qpg1XVHL7h7oFlEpI+sFzAimiGNve2RhYyrSySPnAj5MP
 EGp4O1N6UwKvAOLr1bgwXne9uQm78TLom4ov7OYNCfgHOsw3RhWXaMmPi
X-Gm-Gg: AfdE7cmrrlp7chX2Cgw7geplHck2UU8NWSwcwP+goQeJhLLNQEJ2uXvJtBR2MA3FHRQ
 KBiKAV3ykQVn5RtFIZ8JlN15dgwQubcOWNY+5Y0/amcd1BH9Ud8jpP/iz8T1WSdbNeX8xzEde4+
 GDb6GN6GNfGTnlJ6nQ3fXW90dul/eyalTUCe2VknRW1g68Fe1sOgmyRVEmw9KL1FfVJZF/OIDAl
 okOIl/53hSfsiauwx0NKxQb7AJvnfq57OsRdPo4UNbBtQhy0Kox8l9D/A7DwsGpG8hsUbvG3m7m
 VrolFTNeXWUdjBiRrANFXxCK13701FPctomGaKbavfEGYqd+hsNT6+GKL9KAO0gZf3dOTsVmHXd
 Y+IC0nfRBuFA8mjlE9lnJ+efDydA55x+1
X-Received: by 2002:adf:fc09:0:b0:45f:f142:d55a with SMTP id
 ffacd0b85a97d-4623f8b3005mr12508434f8f.14.1781796633902; 
 Thu, 18 Jun 2026 08:30:33 -0700 (PDT)
X-Received: by 2002:adf:fc09:0:b0:45f:f142:d55a with SMTP id
 ffacd0b85a97d-4623f8b3005mr12508305f8f.14.1781796632834; 
 Thu, 18 Jun 2026 08:30:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm66063223f8f.1.2026.06.18.08.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:30:31 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:30:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <20260618112415-mutt-send-email-mst@kernel.org>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618132058.1044341-4-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> + * The maintainer(s) will develop and/or review patch(es)
> +   for the issue privately, optionally attaching work in
> +   progress fixes to the GitLab issues.

attaching how? how do i ask reported to test the fix?
was easy in the email flow.

> All patches must
> +   include the issue URL in the commit message(s).

you mean the commit message of the patches I presume?
there's no commit at that point.


> The
> +   **"Workflow::In Progress"** label should be assigned when
> +   a maintainer starts working on a fix.

That's a bit heavy, and what is "working" anyway.
It's an issue tracker not a planning app.
Don't try to make it one.


> + * When a CVE is allocated, it must be recorded as a comment on
> +   the GitLab issue, and the **"CVE::Required"** label replaced by
> +   the **"CVE::Assigned"** label.

Recorded as a comment how exactly, in what format?

> + * The maintainer(s) will update the commit message(s)

what does it mean to "update the commit message"?

> to include
> +   the assigned CVE and issue URL. If multiple commits are required
> +   to fix an issue the CVE must be included in the final commit in
> +   the series, and may optionally be included in all prior commits.

And here, included in what format?


