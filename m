Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CB3EDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXN0-0000s9-8d; Tue, 03 Mar 2026 16:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxXMz-0000ri-5K
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxXMu-0001tc-0A
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772573607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNRo3f93P8yVdU6vLNrgM8WIx5oFIjnqqxwGb/a0fwU=;
 b=iALnxmV9kI1pwXFy5VGFkFCXU/HGF10Jf7KNqcnI1BtI/ylNsD/X7KJqbpvqGr7dIB8gWD
 HjM9P5ozj4vqz0PZ9PWqOi4acULshJZybE/nHeRGIYeHNWhCLhLlYHnuDHjcHfi/PpbfqJ
 AJ2e4pyvu+9Cugwavq4ZQTcX6nKeHiE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-29Qd-ErAOFS6-ajk2e7DUA-1; Tue, 03 Mar 2026 16:33:25 -0500
X-MC-Unique: 29Qd-ErAOFS6-ajk2e7DUA-1
X-Mimecast-MFC-AGG-ID: 29Qd-ErAOFS6-ajk2e7DUA_1772573605
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c881d0c617so3781693285a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772573605; x=1773178405; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jNRo3f93P8yVdU6vLNrgM8WIx5oFIjnqqxwGb/a0fwU=;
 b=T4W7FF0g8Zb4jzfIAJ7OLWTnXe4JGSIiOzWIHr3S+ZiWHAJc9o35ZAjosxeDDlNWbZ
 tB8GZ5CkhKxA0vtEXapy2DtMJ+BDY9DXl7GdfldeNMErWDYHbKLqWHOCACCKJ7AVrNeI
 ymQSWNnAx4hArbZDhEdrgM3cktpZWJH4aGnaXGVMwtq2ROw1N3twYxwMD6XihTJGIRc7
 O40sCWtCqgoPrCtd69pnasP/DESCRXrFbPDLZX+HEumFYmc+hRjTBUFqhbA12IGPqXIN
 DmN+e79R5cIo6XLPmSiDR3+8LFeuQkhQ+3WLsTA7hVxk0OdGxjubSdt/mqjbyUq5m75o
 bDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772573605; x=1773178405;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jNRo3f93P8yVdU6vLNrgM8WIx5oFIjnqqxwGb/a0fwU=;
 b=HMakak6QOlHPWJkS5v2laZMPgV3QDWTmVNao7ty1E+wxiB4nZ6kxJ0NLhUtBEVZz2F
 zh+RuvWs9h/X7BC2MKSSeb9xctyC3CRIOek3MITNpuIe9apVj3kZMXkktxjngke4bTl8
 vnlJjAWsyOzg+hemqham+rcRcOU17tdScFsJrffV54xHMzee5BmV4976gbqRfn67MR8H
 gb96OI8xSEGq7aM1s5+IwVTsrg3ipF5Oil5GYH+uBzleoiEFnkJKUQqQfsc/SBQEfuaa
 khQV6sxXeCdbdEjUHvhLErHudXPE5wAnFp03N5YHyu+MgbPwRUJ8C6CaOd4mkLwnB7Ba
 5rrQ==
X-Gm-Message-State: AOJu0Yz8OaCrGRFHXMfw5EoDN71XFiek53I62KteLgxUz6gMsNhZpljy
 ARSjoa0WNcpgfC7i8aqVCp9aeXuwAc+SSPHIZbWC8mQ4KzpsZPkkLwoMRiVRoCoJEqhr1ayA9kT
 h8Zw2aShVyvx54TQk1MzMiqDUwB/VcnePfVqv74ovBs9FhzzrwEB55r9v
X-Gm-Gg: ATEYQzzw0lVR1LIx5VdS4pJgayo6Mp4jQhsP80kAMS+mQKHvDJUl6sZBReBTORfWvjp
 ggEURocyf0Ebcg1c6dPHIsRQRToEguhfOYUEbRtUO7+Sr0+VIz/iVc3WC/iEmxF3zEFBvILwPGq
 xCI5IdEvULDXCw5d4CyJwuwALRE9Kg20GTK3TztS7EVPq2p7F3ouEgFXZaNexoMou4oDvO2lVUO
 naO+vXVR+/OxLaf04IvZDeI1dD0fap1r/H8V8JlsOtsqJqIBP7AgS7qSukRBezziF/jNd8r4gaX
 FCOZq5OOW9W/3bnqxuIYO/7F/pEvr3gayks31lKtwRVmLAePX4hkPAPEmCwF5RVA4P19nBcdVFX
 9pXHBy6xYxK/2rsMNANwvT6eoTeXRS83QeT5zMEFEIMG/FXEBASD0mQDCjpn/pM95xtvKEkxF3M
 uPF3XwZg==
X-Received: by 2002:a05:620a:1a21:b0:8c6:a539:55cd with SMTP id
 af79cd13be357-8cbc8df1ddcmr2128785285a.41.1772573605034; 
 Tue, 03 Mar 2026 13:33:25 -0800 (PST)
X-Received: by 2002:a05:620a:1a21:b0:8c6:a539:55cd with SMTP id
 af79cd13be357-8cbc8df1ddcmr2128781985a.41.1772573604516; 
 Tue, 03 Mar 2026 13:33:24 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66c515sm1491514585a.11.2026.03.03.13.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 13:33:24 -0800 (PST)
Date: Tue, 3 Mar 2026 16:33:23 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 14/15] system/memory: add RamDiscardManager reference
 counting and cleanup
Message-ID: <aadTo2DNGIDv488m@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-15-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-15-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Thu, Feb 26, 2026 at 02:59:59PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Listeners now hold a reference to the RamDiscardManager, ensuring it
> stays alive while listeners are registered. The RDM is eagerly freed
> when the last source and listener are removed, and also unreffed during
> MemoryRegion finalization as a safety net.
> 
> This completes the TODO left in the previous commit and prevents both
> use-after-free and memory leaks of the RamDiscardManager.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


