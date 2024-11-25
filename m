Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D94D58D73
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdJ1-0004EJ-5G; Mon, 25 Nov 2024 12:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdIs-0004D6-04
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFdIq-0002Qg-OK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732557315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zs5Ey9f8xUXLp81qL9bt3rze6yMFdzt/or2KTgjIyI0=;
 b=gAExXmjMWDR0l6iHyki29WcvxvsSXxDC+Dgdgq7LQHI/qgY3ZLnkouP5Q/cGd/JR6DYLL0
 d2wmmSso0ZakjZuqhcL1CGHLBOPbsiQLUiSelzq7xbNS4Z2WJ3DlNzSNFgTiYIGIq4vO8j
 +KuqUZDuw0Nyj8k4usVvzZXGFEkgMVg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-hbTyXWPVPq-S9ck83g0iWA-1; Mon, 25 Nov 2024 12:55:13 -0500
X-MC-Unique: hbTyXWPVPq-S9ck83g0iWA-1
X-Mimecast-MFC-AGG-ID: hbTyXWPVPq-S9ck83g0iWA
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83acaa1f819so518024239f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557313; x=1733162113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zs5Ey9f8xUXLp81qL9bt3rze6yMFdzt/or2KTgjIyI0=;
 b=pcfVV1NjdOcgrb/ik+uCaTimWj6Gyi2yW7CsiHI9C7sKGdv88NZJd3353kTACnzlpY
 KRJpntK+XNIhVSsz0xuuYMnV7OI1Wof46dpN+zW9CEO/c+AYHL1zmpk0L7WTwA5Sxg4s
 iJQFO8tpIvivoLRrpRJIt9h3Lw7F5Ya0tGfWQ8qzJ29QinHL8ybFaUXR8DX5QPjt93qK
 bPpNyr0V4CQdsDr9dtpssSEyQW9UX3WUb0UDbw05X6xMMykT/mcfv0QnE4HP+6+M6O5K
 KGMPNunHYpyKcGNzuCtnNmhQnJ59f578dq8cDcA/QBGWfqdzvMkWJwNdUeWs6rD5L3pW
 HDlg==
X-Gm-Message-State: AOJu0Yy0ULmKc4kdhjz0cTsMFf801aTdVfME0ErEubK2Hbmf8dVIvwB5
 llDuVi1TPq4cWZmUB4YjElCiF5fyw69/aKVCy6NyThw52CZf3VGZO84N6xUajLGeLx78gae+r1s
 9MKnfZDmDWpqMgHID7mKSTI6A9eVolSu+yBdBrAbUrXgF9dWjA9IR
X-Gm-Gg: ASbGncszsXAD5lHJcA3hMmfm65UevbNK7IKzx9AKoSw+GGW1pQ7vJ2tmDn6v8XMXeU2
 g8x6HCOcAyKnzg+6Hcz9dqorOoe3BIPohwg2GOnsTKr3KSmXdEJ4iQ1DseXHV0aYH4fhlGZCIks
 xHiwR5QzBXjGI+LmDfNYlF2W+T65RxiqsfUt2iwd3s0C9HfEat9SHIqFfW/aRK2EJeMIQMrfHy/
 vdsmBDgogoBjVsCKoEYFz5iubQBQQsdyR56jRuYmQe9d9NdkQv9qId/PP1uKU38X8tO70o7zH2p
 ToNBB1g/kb0=
X-Received: by 2002:a05:6602:2c89:b0:83a:aab3:57f with SMTP id
 ca18e2360f4ac-83ecdb3e288mr1450135939f.0.1732557313092; 
 Mon, 25 Nov 2024 09:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPsBSaun6UWagSByp9uxc+9YdtjCHJmEyHD29FiGsbe0gw19C7mvOuhHH+yYk0Q/5ozKb7GQ==
X-Received: by 2002:a05:6602:2c89:b0:83a:aab3:57f with SMTP id
 ca18e2360f4ac-83ecdb3e288mr1450134439f.0.1732557312874; 
 Mon, 25 Nov 2024 09:55:12 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfee8920sm2276648173.91.2024.11.25.09.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:55:12 -0800 (PST)
Date: Mon, 25 Nov 2024 12:55:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/22] tests/qtest/migration: Split validation tests +
 misc
Message-ID: <Z0S5_pFFy7YRubr_@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On Wed, Nov 13, 2024 at 04:46:26PM -0300, Fabiano Rosas wrote:
> Move the remaining tests into a misc-tests.c file. These tests are
> mostly about validation of input and should be in the future replaced
> by unit testing.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


