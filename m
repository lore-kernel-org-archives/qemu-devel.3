Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BFCD44C46
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgNep-0006Ab-So; Thu, 15 Jan 2026 08:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgNen-00066B-8U
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgNel-0003K1-Nj
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768484698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aEEIf9k5WIt4D2WiSktQOOnKcpYSuWKPSijPWu6/Zo=;
 b=OWG84OVwILTOXlfwQuo9n2hRsPSb+fhLgY+seqHHChKGv7kbeaMjL2ifS1/jyN731UNOU4
 GVHf8cE4tl2MlmiMdbb1HUY2fOt9I6Y/avfHg72nPTtTS/MwYEksNs/a2nd4E8Z7G3ZD5m
 eWN5xyLIugThUkIsvXnOAgCZUWQlkhg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-OYJFCcuuOJqMz81CE9Ag0Q-1; Thu, 15 Jan 2026 08:44:57 -0500
X-MC-Unique: OYJFCcuuOJqMz81CE9Ag0Q-1
X-Mimecast-MFC-AGG-ID: OYJFCcuuOJqMz81CE9Ag0Q_1768484696
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-888825e6423so14820616d6.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 05:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768484696; x=1769089496; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7aEEIf9k5WIt4D2WiSktQOOnKcpYSuWKPSijPWu6/Zo=;
 b=TxVoHlkAtjG71t9qb4qRzVG0g4VyxVqheMy+UBoJvBd1hfJJs5aaTSacAiEDTQerTE
 abEgE8+jqtM/3EGGVsd++5HnXqsiAecdaYIEHdjYAMLvMtn6KrAVCuue8yU587mjnpHp
 27CLVOrIJ1Ry8GOhY9XfJWzCJUbnGuUuVoAiuwRAOapkMeFSGOTTno8jr2xhP0TIoNZo
 mBTIVN/CSoLHFMSLKOeSrM55LxfMCugDpS4WDbFGVJe2PZ5sECijsaBG7/5Zxdbwi7IU
 G14Ttf/4yfbICNQKqwmYfM9km0BQBTvuIdNa0fO4Kcglfjln3vfkiGXnK0zgQbIagQwm
 jeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768484696; x=1769089496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aEEIf9k5WIt4D2WiSktQOOnKcpYSuWKPSijPWu6/Zo=;
 b=aAHRfwtrpjOZow7oEc6FpGoluRkJx2NEmLOxnZUPieAA21sDFMvT2wHsXUwYtdh67s
 0hPAuIyeNEBRt6hqaSJ8aDn70A4qRiofiVuGaM9bAxB6U3iyvUhhfegvk8WGNduu+wDf
 jokDTOMN9ch0xE8PQ+L6fbxvqsLqFJzLShsYv6wJHroXDKD0O7KibLegjMg6CNkw4Cej
 qVx0k8r7qclxxFNYnj4+FwZHdqvszIVdEfMyJTxK/ctIOwYxWWZmbWy21Es3dWp+bTaI
 kwBYbNqQeuaI3jshLIiSz/c+zqZE0MBbkXH8Tjao5T/v7PH/KNnjiDNQIzsGSW0Z6e9m
 bB5A==
X-Gm-Message-State: AOJu0YynKwdYWiPZZ+O5egGNDqBIq6EXUpBP5YIxAygdIiGQSwPJiplE
 46wKShXCuKsVzJp1lfukl3ukFyo8cNmlte9XE4yTHKIsVrMUotZAZhd0rltS/p+eGDPnN4hEOH5
 LhBaRHqE75P/C0sTCb6qSttUyZCbDiGZGnGgLrjTSSrIrbDgqe8To7/OE
X-Gm-Gg: AY/fxX7Qvs9oX2NJ7XAE0D8HqOdQysqvft5p88T+8l1plOFZQIEQn88Iiy1u9pW9Jj9
 kgABX3JzAdHGIwjAuRTlRSj0gCAMCaS+X5tyhqUtsFc7g3x1lorlhRyKicH9dbZ0NIEe1fdWva9
 b5Bh6gRjYltpY42vCRKJ3kwY/DfHEbTNbglAceXGVOF464szXK/p6Jdgdj+zijYwmDrWxXjROlk
 wuC980OWK+M7Me07FHdkhkAhLjTgQ6cQLbhagKOPg9f81TL7IToBis7vo7p72TmIY+RPogU0QiC
 BsVQLlUtsfP1bduF14p5N/UX3qLAC71hKuaDDPrY+ubIk24hFIRLB+5FgQzsAlPGxfSAP0KRBUd
 a/7c=
X-Received: by 2002:a05:6214:212b:b0:888:60c4:29cf with SMTP id
 6a1803df08f44-89275c7bbe1mr83653326d6.68.1768484696436; 
 Thu, 15 Jan 2026 05:44:56 -0800 (PST)
X-Received: by 2002:a05:6214:212b:b0:888:60c4:29cf with SMTP id
 6a1803df08f44-89275c7bbe1mr83652816d6.68.1768484695886; 
 Thu, 15 Jan 2026 05:44:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50148eba456sm34928221cf.20.2026.01.15.05.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 05:44:55 -0800 (PST)
Date: Thu, 15 Jan 2026 08:44:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/2] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
Message-ID: <aWjvUS1BOBfuOdGb@x1.local>
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-3-peterx@redhat.com>
 <CAE8KmOz9XtaEY+LMD9CCCR_bMXe04chGHdvuwVqsYRNe+AtUJg@mail.gmail.com>
 <aV6UhNJzQLnDaJvO@x1.local>
 <CAE8KmOzPHTf6eaufn3dWTJJ2nsifdxZzwENK2hD_LZLGiE-pcQ@mail.gmail.com>
 <aWe35LsGn_68MIUu@x1.local>
 <CAE8KmOwgSyVYBsUjsY07ynKU3YUYn=2pmSCxZnKT9=nQVor7kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwgSyVYBsUjsY07ynKU3YUYn=2pmSCxZnKT9=nQVor7kA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 15, 2026 at 05:27:30PM +0530, Prasad Pandit wrote:
> On Wed, 14 Jan 2026 at 21:06, Peter Xu <peterx@redhat.com> wrote:
> > > * Let's make it fail_stage in both places then?
> >
> > Could you explain what's the 2nd place to use it besides the parameter in
> > test_postcopy_recovery_common()?
> ===
> tests/qtest/migration/framework.c:
>     static void postcopy_recover_fail(QTestState *from, QTestState *to,
>                                        PostcopyRecoveryFailStage stage)
> ===
> This one. ^^

I don't have a strong opinion, since that's unrelevant to the current
change, IMHO we can keep it as is.

Thanks,

-- 
Peter Xu


