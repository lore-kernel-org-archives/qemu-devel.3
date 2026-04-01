Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D234D3517F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w80yF-00027i-Or; Wed, 01 Apr 2026 15:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w80yE-00027P-OE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w80yD-0001Wf-5s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775070674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ChrdvIwLUuX3BpFyQDdvviMYo4R9DvYE42dIEjKzftQ=;
 b=GMI4mdQDl0Yl9gHv86+cyqbvZiXmWSgXORmmmfIUXokSGAZLO/3wQbYcMHQ9SgPILO+SY1
 b47qX9NUkMAllQxkgBl/Kx+AFS81Zihdm+jg4hiQMfl1eFPAej2pizIUgvf85G9Pfx1lNL
 99SQLjHvrI6ZIp+EtkqtIKho2Cv1FIg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-M52suCRzNeOw12eo-_q6zg-1; Wed, 01 Apr 2026 15:11:13 -0400
X-MC-Unique: M52suCRzNeOw12eo-_q6zg-1
X-Mimecast-MFC-AGG-ID: M52suCRzNeOw12eo-_q6zg_1775070673
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50937cf66b5so2061291cf.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775070673; x=1775675473; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ChrdvIwLUuX3BpFyQDdvviMYo4R9DvYE42dIEjKzftQ=;
 b=oV0j9OKCtLnb6Ms23iuiIWzvnm9dyzWJQFzpx6QVV0gT23aqeX3PTPTGkIRNSN5T2I
 Zz7pXx20s7D/EhNFbo2DIaH63k9iOoGtn8XBtAfQlMSVU7mDeFwFWUpR3Y5DFUwNiGQj
 EyF5Yfcv7+5l36yD/o1Wq90zEh93yKib1zdZ6Un6rwzhaELQ5prUM3qAN0rYHdeN+Z1V
 9FLNWlyO/psGS16GSfm70c+4RnuXAOrOabY2MMQHbw43VbTpWnrv05tDHue1uOFSVn5+
 LNs7ZnLi+q46QE4CJQDyxlPbdUkOj/ZzyRUw7e+Z79EZS9EP3s4hmqxDY2jbWf8gmuLK
 acrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775070673; x=1775675473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChrdvIwLUuX3BpFyQDdvviMYo4R9DvYE42dIEjKzftQ=;
 b=E6RS/R3GJiuvu15n7sKjkbYWqQCCK1uqkI+x+d6yqqfujXk4YnHaJLl42H9Tb8piYR
 LAbK7FvZ6i/s/ouVVKjGM7F9+XxA+VcQyqPiM7beCUIbWCMv1AjvIXY0726PBWCl/jOO
 et+k811lT3TpCOxz5uhx1SaBwb8bHSqLel/LRfuVizx3sXTK2Mm4DrEb5ZPIS/nMY5He
 fA3coUkcSmgYIO8JP1O2kTLCVOnFbMrNgXT+bT+2qnU7riOy+ahKNXG70oeH4G9hgM71
 aMv/G1Zppqc/zPyq1086IUm7zPNhmVCvPifnH9nzlUTlVAzKyYryAZhup8tXNLzsJYOy
 jGwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj1PCFOcYoO1DkJ3nKmUopUj0AI4MKjdxkRJoTLjdDFjGyzkGC0bK//c1wQwLWS98VHwzKbh6zdD9t@nongnu.org
X-Gm-Message-State: AOJu0YydWCJEh+lFhJk2OIGjb2L106JgZYyrmnZuLKIFvvYggxywl1/c
 gQBJGZxmD1mEVu5NARkxdY1mT2B4J6rzYvQZmlYyQ7eYUC7onS3vPIkgB5gcCU+cgxBcX0Izgs3
 0BnV3jfDa2HPJkYxQrCJFayJeYwzlEy1tgaU1lpHNnNWwIAM1Qy4YzkPY
X-Gm-Gg: ATEYQzyz3owtdswRV2uLx2xylqcTx+vp7WqZ4l3RNsx/ae89zWwyDggHGT95StGV0G2
 X6OgMwFont47kxRnrUEDpf0/bYy8ku3Yo78nxsACGKe/joHeoG/mwsRQJC1+t3S9xQsix8KCBTT
 aPk4E5T7lolThzcJD9J2nvxST0Yzz7hqcJGG/g1lFlSOItZuA7Cx2dj5XMCRXWYMLxLlmFJGQw1
 RURlsPS+xhxIM31u8PG/P/QQmZBOyFSo8jDxakGquR6mRajesmvvxiqcL0MsK+ZlFmCHW3t1J8/
 P9fT7lq2QbTd6aqM50Eg59rpJvNuhI6RxwqDpJOdRHh0qyOuo6mWBhBtB7DjN/Hy2HHMlrL9kso
 H2flhK/lop1Yox4N2t4PtyECYiQLxJdUcRjow6Qf9GEs7Rw==
X-Received: by 2002:a05:622a:2305:b0:509:a9b:8a6f with SMTP id
 d75a77b69052e-50d3bcf4d9emr69178621cf.56.1775070672788; 
 Wed, 01 Apr 2026 12:11:12 -0700 (PDT)
X-Received: by 2002:a05:622a:2305:b0:509:a9b:8a6f with SMTP id
 d75a77b69052e-50d3bcf4d9emr69178201cf.56.1775070672366; 
 Wed, 01 Apr 2026 12:11:12 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b93dd10sm4211301cf.7.2026.04.01.12.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:11:11 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:11:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH RFC 01/12] migration: Fix low possibility downtime
 violation
Message-ID: <ac1tzs0BoMF_K9em@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-2-peterx@redhat.com>
 <CAE8KmOyTq4wib3niowjXNfqh4TjwhcEDqUt99=mvuLs5vsSx9A@mail.gmail.com>
 <acaNfFWvNAEpFsFD@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acaNfFWvNAEpFsFD@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On Fri, Mar 27, 2026 at 03:35:35PM +0100, Juraj Marcin wrote:
> @Peter, not sure if it is necessary, but it could be usefull to mention
> in MigrationParameters docs, that avail-switchover-bandwidth is in
> bytes, not bits?

I agree, I will add a patch to update the doc.  Thanks for jumping in,
Juraj; I apprecate that.

-- 
Peter Xu


