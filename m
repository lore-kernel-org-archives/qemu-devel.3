Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAC9D6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJTQ-0003mq-2f; Thu, 18 Dec 2025 14:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWJT8-0003l1-CM
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWJT4-0000bH-Gf
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766085316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxmjktm0qvaPoNZeGs02Wyv/y65xpVuTVaCbM9lE3E4=;
 b=gcwvE+dr+eiQmgO4Z3ey0KA0pEECJvLsjLk6RsxqNk3ogue3z1LIWP3z+3Ou9kSA7kVlC5
 pN4Y4WCRoLG4RWTxvJCMhnnDePZYKgAjWQ2XRWmmI+/ygCmhCifz6elnSyPOjc5uDKp0jv
 sgLtWf0AbPT7Yxt2jaCZ8JaPlsGzdiQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-ekEIFyFQPF-SIU6BPPo3Og-1; Thu, 18 Dec 2025 14:15:12 -0500
X-MC-Unique: ekEIFyFQPF-SIU6BPPo3Og-1
X-Mimecast-MFC-AGG-ID: ekEIFyFQPF-SIU6BPPo3Og_1766085312
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b245c49d0cso217424185a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766085312; x=1766690112; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lxmjktm0qvaPoNZeGs02Wyv/y65xpVuTVaCbM9lE3E4=;
 b=RgakhAOAFwVSXKefwCNIyZgd6b4OHYjMExGEKIoWXUfzeUJfgIDeRCBFsuHYIlnjYZ
 4sAkzgmDIMFQn6oRaq7iOXMeBxsdDhoF5MK4deRpHLgbJxS+LczWjE08ZJaqv5oi8ubr
 dvQN02WMlPg6Y5ya92QdBo9s5i2d25Kpq1G9jo+bpebfHw8FmWq2MbEUzEJtoXHK3stV
 e+zO5+QfUk7nmvyhq2BlO0Z1vPNznfSpi/VDJ1FibNUwa3hD/nU7lD8B8Rj4ycbESYu0
 Cxk80KXGB87EDE8e8H32t/ddfu13tGB6+WS0owDy3amUbZq7NBsBRnogO6KD26uKIeUF
 Traw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766085312; x=1766690112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxmjktm0qvaPoNZeGs02Wyv/y65xpVuTVaCbM9lE3E4=;
 b=TQ+NDgEch413VkAajTOjAHj1oOizediY3zO78XfPoFWmxI/2Yij9zMHtQWyO5LoPj+
 WhplilF4dDy5L7C6sobBPbiVzZAyM/pGUo1z1HHZixRNJNh9eAyxkim/suAFggZzoYkg
 O+L9vbwBoIIAdssHookG1mVzsZv/1BhLue7MfcBJ7Enh+4E66GHfeTNxjdHPZDzzO/iY
 ny7ZcUl9+Q7wO7VKZguRAdiBnmjFSVlpPfhgA3ye8XQvWoMOvFzMIYtr1MxOd7K7Gn7H
 frc+O/HS17WKi7ZNQlGAFJTnkBja1y3pPa8V5bcAqaELCTv0ZeuEVT9xv1y3spRwvP4y
 hhbg==
X-Gm-Message-State: AOJu0YzEk9ALc6mpG5hmtXQHiezR1xgLn10DWSS34VCwcSbNcRgGMawP
 dZ+N2dZZOctM2LGcC0qrh/UzvH6zSE6/Bua9z6vq9Td7GFJ4SlXzikBZq5F8aqfaNBbpqU+nnb9
 UYlsrsUwTnUKkbJkUjj2AkUczkX3cmLCdkOdfjJC28DbrnJLxHz/MUCFR
X-Gm-Gg: AY/fxX4AH7uPkFSTJvZViz/ChTDmNlaWbdfYfo/EFGvs8rp+nXEAuPk4wd9+2Ny/HnG
 bYIoyOHborhkc25KvZvZF22mYsbcsdKB/DIUXwtHDMIifenl4Q1mhIxfeLNMrz3sXPVloJw3L0R
 PXdy3StDepn1IWrilLG93pvl0+DPEsEtcXY95es2TCzg9Pl/cJdAuyyv9DaTCVGuE9F3GCdkUV6
 56Pso+L6STvqrCcanBufvUy8kxiuW+tBtIFc1J+iz8/vjOGkyTHAdAArNe9vvioJ9qyuR+sB7Lv
 SWT1Qd3bRjC/n2fX44wnlktpXRVA7QZZ9ze4+GZUx15Io05GrSXocrV7Fv0d0m0xVicmwbBstbv
 WLLg=
X-Received: by 2002:a05:620a:4690:b0:8be:738b:ecd1 with SMTP id
 af79cd13be357-8c08fbdc02amr113446085a.89.1766085311723; 
 Thu, 18 Dec 2025 11:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwfKRhR4j/cM/QlNbZ38qSJk0LZYALN/NZ7xV3p1ra57FSxQCe4WAgaPG1pfNWhVltk1h4Ew==
X-Received: by 2002:a05:620a:4690:b0:8be:738b:ecd1 with SMTP id
 af79cd13be357-8c08fbdc02amr113439985a.89.1766085311226; 
 Thu, 18 Dec 2025 11:15:11 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0975eec8fsm7744585a.54.2025.12.18.11.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:15:10 -0800 (PST)
Date: Thu, 18 Dec 2025 14:15:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 38/51] tests/qtest/migration: TLS x509: Refactor to
 use full hook
Message-ID: <aURSvVtgSj0rQYCd@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-39-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-39-farosas@suse.de>
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

On Mon, Dec 15, 2025 at 07:00:24PM -0300, Fabiano Rosas wrote:
> Refactor the TLS x509 hooks to use the _full variant which passes the
> hook data into the _common functions via MigrateCommon *args.
> 
> This reduces the number of hooks and will allow further simplification
> of the TLS tests by setting a common hook at a centralized place in
> the next patches.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


