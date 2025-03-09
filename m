Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA43C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDtn-0006lb-UJ; Sun, 09 Mar 2025 06:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDtm-0006gi-1S
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDtk-0002rl-8E
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3/T5P2oAUF10DYW7ZiBW/R86qLT70rCJsxPBXNqRHM=;
 b=cIeCssYCErMWG3Ql8e1LqRyjF+09C3P5OggjoijAYe81tf6P11lyQ18ej4xJ1HAklnnssG
 qvzGUxHblvg1e8DhL2awXDTGcLRFqzT8GblT5upZYSp7pK2K39S8bW8KoyEOb5d++YNgSe
 a34wKhZ2PbSoQOpPZBX/SLcg87dHmXU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-n1M0LwHgN0GmahCCzxG8kQ-1; Sun, 09 Mar 2025 06:28:36 -0400
X-MC-Unique: n1M0LwHgN0GmahCCzxG8kQ-1
X-Mimecast-MFC-AGG-ID: n1M0LwHgN0GmahCCzxG8kQ_1741516115
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cebfa08ccso5190515e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516115; x=1742120915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3/T5P2oAUF10DYW7ZiBW/R86qLT70rCJsxPBXNqRHM=;
 b=C43VxlbC6M3t/FN94sI7QtOa/7pNzKiNpSAnjeE/5K+DbY0wkKgCvLp2Hm5OKNZNTj
 vTNe36TLenPAUrcHctN2/wqOyD9f9G9XNdisP37maGPiFQCiwkqNKY9y13vAUHZjZywF
 +qKZtBGxzt6UBIgYZhP2I46zFpkqEWUyBmZ0HEoxfj+lS/eT49keBHEyag3UEpvpdweJ
 ky8JEmhzoF2knXnL2cL/e5qXGt5+wi+21MlYpokMvX0To3R/B6IeTKHlZ1mhRI0QszBM
 mMuqMGkFt+ibT8OTa2WTr+H+jHVeBJD3nGMlv64Y03kLZ2kgHXHGRVoHgu9HUJw1TIUe
 MRxA==
X-Gm-Message-State: AOJu0YyULGkgVYF/7YSizvC3uDFR2A+X66+xgx25SCYqWszzGATIFRZI
 TVfUpTP0CMvLG8mkt1TznETUWFpn2ElwzgUwXfZy/ZpfePIsqqotp5eb6PHNsxIe0OO5dJbS01B
 0y23UwyZPPkDci9MjVmgcHu5AtsYTZ97T8MvHmhsOtfnJSCwYebn+
X-Gm-Gg: ASbGncu/LUlbde8z2AS/QYU1U9iaWrPKaaOViwAGbpu8Ua1Qu46Uh7cgCIZcyUZ2Xlz
 AVIGhzPF8OM3VslB4WjUiv9Uj4P0Wg2CP3uzWhQUZDwlfxY5MH7ugTh8xCF4iIGRUjCT6w4hxhC
 53InJPqmEUrrddjsBZLx+5CmTjbpv2vuL5B2qZ23JRFe7mLILUUNKab0rtIwbuPREYSkLZJXpxv
 UDNp6QfEC9slB+mStwgryfBOXkHk7yucHJb8YYerB3S5MVFy5OygwKpnMWD0fLpTT8mxj0pPtmJ
 n2SEkWG+x+/RzEhHpWZw9w==
X-Received: by 2002:a05:600c:3556:b0:43c:ec27:8de1 with SMTP id
 5b1f17b1804b1-43cec278ef4mr23694855e9.10.1741516115328; 
 Sun, 09 Mar 2025 03:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJfQbufps26AdeJodkGGedO21xdIzJbZQEfykTBPLsX+8CK4YzvQjFZedo8tZ4vubcxQY9DA==
X-Received: by 2002:a05:600c:3556:b0:43c:ec27:8de1 with SMTP id
 5b1f17b1804b1-43cec278ef4mr23694725e9.10.1741516115043; 
 Sun, 09 Mar 2025 03:28:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0461sm114433225e9.4.2025.03.09.03.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:28:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: pl011: Allow NULL chardev argument to pl011_create()
Date: Sun,  9 Mar 2025 11:25:19 +0100
Message-ID: <20250309102518.1115001-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307190051.3274226-1-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> This is my first Rust related patch for QEMU, so I've
> probably got something wrong here :-)

No no, that was all good!  Applied, thanks.

Paolo


