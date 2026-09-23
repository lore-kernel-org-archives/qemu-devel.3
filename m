Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE07C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Q5F-0005yy-Kv; Wed, 23 Sep 2026 12:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Q5E-0005yi-Oe
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Q5D-0006OO-8b
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790181873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=UbuH7Iv23tyIjTCKYm2ck2DBp0biisrNkrcNquPnwoPxy13NrutylwpqqtIDpqt5SH+i5p
 6kVSPP3+X9GNESfCtNJ2WaSOPtB7/xdB0wGhQt2QKBx0a3Op0ZPXuPIOodsoSpg4Z6pnNc
 g3mWCfoBPaXpAWFdJkmvtYuD2NErk/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-5IYPUiH1N-qQFN54D1Fs0A-1; Wed, 23 Sep 2026 12:44:32 -0400
X-MC-Unique: 5IYPUiH1N-qQFN54D1Fs0A-1
X-Mimecast-MFC-AGG-ID: 5IYPUiH1N-qQFN54D1Fs0A_1790181871
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6422198fso7812245e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790181871; x=1790786671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=H58C+FDxzCmZ7fSqm67Hdn2h3YJXfx2h4xhx0R4NcSYRdaiykjzVf0wy+rf3ycs25Y
 GHobALCuP91/0Xga+xual7Jxyqqn7gDuba1HFnGSMAMIMuRhxUIasOFPlY3BOnk1qjfx
 GmN2uTQt5EsDlVxHSZZX2qsXhs1wxtzVxCd9DyLdtWfu6Wtc30IPga3P0Mf+vyK3bqQO
 LkHmIVU4ZcFRj1EL0ZMH6qFduJ/H2wiCeJMwGVk59w3KimXQwlc1UEWMqfMyX01rM75c
 42mA8xQBcx3Dgp2oflGV9B6NiHtaLAB9HQJZ+FCoTNWeyZ6hdRebBXZ4kCT5j6aauLC2
 TIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790181871; x=1790786671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=RDEvTd3xNdIwQ5gxQX86M03WvpKMHYsuZaT2TPxT5+/CdeSxkjOHI41N1TchCQgvSK
 kunkfUQ1TWIF1nKKWsNFjkq0ZjUEDG0rACzqOPBXVhZk7oYteX+tj6DBqtM1GxbGl+Qe
 XOebRQFIxAUxQh/zEEt4SryfuMIlYEEdN3L7giJwS052aMToW20uGIsYG+giPKpUZinq
 pBkCvrW190wKZ3OS9BRvaRENIdJHw3C5Bd/IX7rMA5MhbThAMhqIzmaIAB7HXwWvAw1v
 chdJsTGziJR+y2xzWJw2bX4Eq7d8jWVXhEbyy18qWL9TpOY/BlJFNFnBdvx6OBDWw2dy
 ERHQ==
X-Gm-Message-State: AFuF++nyPx1b5ToNXYBWQiU9K8OTCNkRDglyzwEhRobslcNblPzNs9qh
 DTE4GxU7WSiLstFyC+SWsegyaYBQjU7f42ZuYh5BH/RZGCl0/cK5+/YaNgwGX3sjaEqmTKwL/sc
 zvxMDd1rDu4RhhdUEMotl07ufKnRwlVX9CxFcqcYG2ILrXtItfD8il8d4
X-Gm-Gg: AYBFou3k2EeVfZqtd6Cj+pasxgaYuuZ8HKfNsBR746Z/eVlgT1T9DNi97PyGkNwTRQJ
 usSPl2UrpiUuQlu1mgPCNYgoLvfA3sVRkUF0DIgWD41YYInkwLLpUY7CDSPg1y0fKIsDglhcgD5
 Wi5X01tmxlO/gL+wxDspAMGGIZ7DOMh5JV4pf3ZdRk+yQlXoTw/U8FL6+Tu/CRaWdOc/rvTHNU+
 xYk4RK9Rl5zcwuj1JQZyRSoKryAugAXLjKH0VpX/rYnIBxT+6AW+zOmDkAsHRTUb84g7XVUafX2
 E4xdhH3LiI4sAD7AyFK9nriRC2z1wy/L7Mvl7Mge0sIBEuaX+2Kw/rYlKgt7fml/j4LcfbuRWtO
 AzpHOYMqRV3bWQlIaiBmZXzRG37h/k0EPZCYSrLVwI32241JCI2d5BzeGdrj63K6U4UDSNaI1sW
 Kdc7ap
X-Received: by 2002:a05:600c:c493:b0:49f:ce78:3564 with SMTP id
 5b1f17b1804b1-49fdee0a323mr45794895e9.21.1790181870934; 
 Wed, 23 Sep 2026 09:44:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:49f:ce78:3564 with SMTP id
 5b1f17b1804b1-49fdee0a323mr45794575e9.21.1790181870620; 
 Wed, 23 Sep 2026 09:44:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf9691e2sm79248945e9.1.2026.09.23.09.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:44:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Vulnerability Report <vr@darknavy.com>
Subject: Re: [PATCH] accel/kvm: protect kvm_resample_fd_list with a mutex
Date: Wed, 23 Sep 2026 18:44:15 +0200
Message-ID: <20260923164415.304938-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923004651.101197-1-mlevitsk@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


