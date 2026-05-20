Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B4DCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPm6D-0000TM-DG; Wed, 20 May 2026 14:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPm69-0000T6-7Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPm67-0002bU-Kf
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779303410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cYBlNQjJfudsQ1dmmZeBDOz4w6QRCYHPeqOnV6hUn2g=;
 b=a65/wHUkj3EitowDXdtBEm0IVET0M1t1nJ++/IME97qKqVJZbbLrK9OBOkMURwI8vrcNYt
 QJOQ7gBaU10/3FzXPMNKX/bUmWYGbhS19BulFkoKb7b0OGTDtgIQHrIVI/UMbYAVVsKGux
 80FOkP3NVUXoCJF1SP3vQz7nAuwnQWw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-C6UqAo45O3SKGyWfox-SIw-1; Wed, 20 May 2026 14:56:48 -0400
X-MC-Unique: C6UqAo45O3SKGyWfox-SIw-1
X-Mimecast-MFC-AGG-ID: C6UqAo45O3SKGyWfox-SIw_1779303408
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d6bf346adso117370901cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779303408; x=1779908208; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cYBlNQjJfudsQ1dmmZeBDOz4w6QRCYHPeqOnV6hUn2g=;
 b=AtQA7mea0osu2y07MAMWX4YdAPEaiNZUCt/p179y16O1yFn0ycchTuS3sZ3WKlkFkB
 CYNGLSutzaoxojmXQPPS3LQ0xtAiAhVCMDaQLNCo9/CauisF+XkFt3mtURJ9fKbRuFGj
 akhO2sSX3uEBYz4q0GPoPBd+Y1egWN2p2Cs0laAGcBjblM5NJy9aRkz44h7wdnRlUdIN
 p1vagOTX/CpaPonVoMcAHc8hifWQtieF2Q++jdm8HF6TL5jZd37i4etQ104jT7rTFIUp
 iQbUCJpHTlnKFCYIEnzhFZW4fN75F0c3nFWY5j33Di4x2yO/p/bKJXGDWpYiO934Wwh3
 /oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779303408; x=1779908208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYBlNQjJfudsQ1dmmZeBDOz4w6QRCYHPeqOnV6hUn2g=;
 b=rDoPapey+zQmLWM3NX9uM95nWSQYddtWjJKxqUpekHX/845MU9fFQWYg9LtKwUWMOf
 vBMKuEiVOQuy5jbHjElUL7WE8FAT2+Nauzk3CuFiJoK/6sZqUXxiO3phY07VKs4Mu7GE
 b9JPKP3emhjQr+MSAR5o60zzHP1fs/wYEu/v5Mg8Q6OGokg3yo+0v9WsYce4mOy+NzXk
 wD9xx/QUpx0osSnn9MiS73YPVTTkBkA6jBmydn3lRB24sGLw21xpjT7GNJ+BGCRuRbFm
 sz2Yb86bGca3tWpXFPnOkmfkHvh6l0Ylbfi7ektDNCY5fwB+GaKU2olxHv1G3FUX/sB/
 pMDw==
X-Gm-Message-State: AOJu0YxRdcif6bsX+Yu1sx4oQJfY/awEp0r2valNJoEtlgJ/KMzAROfV
 gqhph2mIpu6ys81t5gk4ImNbgAQ5nm8mU2sfJ8zS3OERWdpuRBnzEnJbtrLQgDZwntKKfYQjaUq
 XydUHX6RGYilCMRa1kSjvumhTacQQAvWvlH82HoQPdxcs/rQmzkM2kbKa
X-Gm-Gg: Acq92OHwfSRRvtmnsgGeJ3FHlbjN2FgcdMVhEU1Y6UogipoPrFbMMcRT8xG/DHBBpnu
 hlcr2Fs+xJstkwGj/uii1tKuMKS2UQ9R/VbveEYJ6UyPW+DtiDRzZofJKNY9nwoZAVvSSI089/7
 X8nbhZOFohpwn5PA8+W9gkXMBZzZ/MGvKkc2tPKtkyfAWMAYPWHRbEslTIaNBNxVpPHNTDKtc5N
 FjWEWfcMtSlClTcdPA2FkKoTZekrgVgJh3/3vVnyqHgHL7h+rTppElr+ZxcWbQHpIaprIDqoSLu
 /J7KXdDs3XGGYNn9ofqHx9hovV11AS74Tayx/A1MYUf1CUC4sMjq9kMRJEUl/roZrzfhu/iDqWn
 9PltACl4UPbGxMFj4kCxNF4VeVjJzsi/qzkmHCcBuKkIj4Yw=
X-Received: by 2002:ac8:5d89:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-5165a01227cmr341106401cf.9.1779303408087; 
 Wed, 20 May 2026 11:56:48 -0700 (PDT)
X-Received: by 2002:ac8:5d89:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-5165a01227cmr341105851cf.9.1779303407365; 
 Wed, 20 May 2026 11:56:47 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca3619dbc2sm129949856d6.38.2026.05.20.11.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:56:47 -0700 (PDT)
Date: Wed, 20 May 2026 14:56:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/15] tests/qtest/migration: Always defer
Message-ID: <ag4D7Zue4U9P6QKS@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, May 05, 2026 at 01:08:59PM -0300, Fabiano Rosas wrote:
> As discussed before, change the tests to always use -incoming
> defer. Also remove one of the uris from MigrateCommon, a single uri is
> enough.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2501387628

queued, thanks!

-- 
Peter Xu


