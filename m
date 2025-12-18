Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B594D711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLcb-0006cy-88; Thu, 18 Dec 2025 16:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLcZ-0006Uq-GF
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLcX-0000i2-W3
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766093592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLt+QK8ddXSzMPw1NJQwbUPbmGhN2BEzDiFyYQQ1Qjw=;
 b=NYuIanAIfi4IaxsuSK3kkMt8NYZylyCry4okEDW2MCB5AVMp/RZb04WX0RyaEPEP34aFzE
 AutYSibb8RNi+XTjtl4zvnR+MzdKR2xc8PpNidE3s5RLTh3ikwGJ3VqbwdWcMga0HXqilD
 TwxEU5y8FDb3EoChF+fbE5xbycQOJdQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-HzPukBKtOmGV79CeoIg72Q-1; Thu, 18 Dec 2025 16:33:05 -0500
X-MC-Unique: HzPukBKtOmGV79CeoIg72Q-1
X-Mimecast-MFC-AGG-ID: HzPukBKtOmGV79CeoIg72Q_1766093585
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b55a033a2aso218963985a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766093585; x=1766698385; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mLt+QK8ddXSzMPw1NJQwbUPbmGhN2BEzDiFyYQQ1Qjw=;
 b=XaJQ2HGS7BbJOs++ZTCmc2areCzfK1KaWRHRTqu3CIESpdkvypRJ5+AClNpFnzJBrQ
 mg9EXihorTU7ZcD+UhWCvto8c9NZSAyD39YFHHak0zI2caNlsFzcoZKN2g269x72YVMm
 auto2bZqc4zJJq2BMX9LMkPe02aOljBlRPnB8+oVYByJlEmKAoAPNpwzQ943yOsaz7da
 G/ILI5RdoTw53rOn2tXLyQILR+sCrdERJo9NXrnLTp5HsIaLp/1A9Tt8/0fP7Bxkcc83
 nep85xTrwfnBQheLBiRr81suGgx4GDq+5z6fKu7VaTfbF+TotHS8EPXV5nkx5aR87izW
 LCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093585; x=1766698385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLt+QK8ddXSzMPw1NJQwbUPbmGhN2BEzDiFyYQQ1Qjw=;
 b=IuaDXWsrryZjnTOHhsDyz9N/6toMYZs9g8qRsezOKxf7fEV+unVXpJr7vjaGZpA79w
 Bx8sGQEt6ru51lyccn8F0c2LD2aVw+0kmbxyWUeQdmK38Xq4sLQQSernWgLvq3hEicNR
 ojE/PgOZIjEiRPdexe23UVObmRIbekQhFguE4irAoqIP55qfqgBybb8QQPNQOlluoVzv
 lj6PsnbySOgxmOcDm0eH/n1wYEd0lNu1pZqXuDbSgF3lDfKubgePp8E3N4/z76gSO4nT
 KCt2AFNKfhfx+7wahYvLJ+7aOjBuUxErxxmB391ztzAdHfaMwGZS81lUN3ZkMKOo1E0C
 pRPQ==
X-Gm-Message-State: AOJu0Yx3K9/sSWkOLdGLJWWHzOgBSxsh7lcc+kHXk24kdFj470h8iMD4
 43SxZk0D2naUWCDZQe2sE42MTluBj6SmDAastq7GvwUi2S9NqoX6NqyHzPkHidFWgsxRE6Ksp2i
 Zd92DiSYzE9CiGTleRIBpQdXCI0o6kqwoZDV6Pnqs18ktrPYIklcDvr13
X-Gm-Gg: AY/fxX4CwNNfMJiKH7r0/eeNErYoJhJlZM8jGQcnkqQ60oPokMSt/Db8LHuNaN93+Qz
 P118lmf+obFqKL8xptSXgutWd2pXyieHUJlZ6FQDuJnW3v3kOyYTmwArvUiuCdq+tj1P/vv2Z4s
 mZqm3gs+qW3ZuZKnCUOYJepfrpMHZo2ROr9XmZI+KS7hra0VG08XokviszSoy+1NVi05Aq724GP
 CgDI4KPewWmlqDuwrt7MJMRRvJf1q1fJHYADTrFEsTg+ldidWvhoa6yDDdvBgi864eA8qM1C6BA
 yYjRJW4HXCzfks8wC8Fy0esm3h6yyhK7j4jD/gBPKI63mOj1H6SX6WVYOxkfrM/qaN7K2fLTPUH
 bLIk=
X-Received: by 2002:a05:620a:4725:b0:8b2:f2fd:e45b with SMTP id
 af79cd13be357-8bee79ca97dmr693259785a.36.1766093585059; 
 Thu, 18 Dec 2025 13:33:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiRDUIVAEzhWrruBo7GvJEJaKcRFd7HvUH5e3PTGVrxz2bnTmCoKa8x1BRBq6LOy+qv/ipPA==
X-Received: by 2002:a05:620a:4725:b0:8b2:f2fd:e45b with SMTP id
 af79cd13be357-8bee79ca97dmr693254085a.36.1766093584352; 
 Thu, 18 Dec 2025 13:33:04 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997ada77sm4495796d6.37.2025.12.18.13.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 13:33:03 -0800 (PST)
Date: Thu, 18 Dec 2025 16:33:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 40/51] tests/qtest/migration: TLS PSK: Refactor to use
 full hook
Message-ID: <aURzDqLIhCm6u2ZL@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-41-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-41-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 15, 2025 at 07:00:26PM -0300, Fabiano Rosas wrote:
> Similar to what's been done with the TLS x509 tests, pass an object in
> to the TLS PSK common hook so a couple of extra hooks can be removed,
> making the code easier to follow.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


