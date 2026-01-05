Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2D1CD0406
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcrk4-0000xc-W8; Mon, 05 Jan 2026 16:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrjy-0000tp-HK
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrjx-0003aQ-1f
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767647028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlMTSoAiQ8gEDlqYVx547vNWomrXHtU184/JsmW9UZc=;
 b=NTP2C4lm6fcz+19WQQAwrLFb6pBo4xixsyYXkogDVO/ZcfMi0gmHIwzptHMt33nm61mykB
 J8TtG1WPnhDDMBdjhsFjZ7rN8moc/TC7yM0Kgog/TDnPoQJ2gr6HbJsUKP0OdxPTJBDKXA
 FR3jwqzmtHolWpz8npDF+MpmSvCojJ0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-arkXXBSuMvad-bjcXM49nQ-1; Mon, 05 Jan 2026 16:03:45 -0500
X-MC-Unique: arkXXBSuMvad-bjcXM49nQ-1
X-Mimecast-MFC-AGG-ID: arkXXBSuMvad-bjcXM49nQ_1767647023
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b259f0da04so73955985a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767647023; x=1768251823; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MlMTSoAiQ8gEDlqYVx547vNWomrXHtU184/JsmW9UZc=;
 b=fEIqS3HahvoJkcnMtCn0shryR5nr51y9uP7hnlNIwfqdI3qxllsYLQV9HG3u4TpVy3
 GCfRXHo0ioycBpQ0MkV0+k7JRttpTjf6CVacLS7QBkJ9LDX2fe0o6o7+tZB0nlqPBD2y
 vl201w+q3ROKIQDgngpwOjUPyDYJvxxIhodtSA4AhAP6VSH+91wS6e+xm2BxK879Glg3
 ygaw7ruIIICPdH/8M1mPoi6FGqvBX9HM6ehl4saU29fpy+EgnjR6xWZmXBkxbGxOjFCR
 h63w3mae9gTT1cGDoR0lEcF7Y/yt1oHjmceRZVgcRVUiy22vUT2i1+VpPEvs85Rkq42g
 n7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767647023; x=1768251823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlMTSoAiQ8gEDlqYVx547vNWomrXHtU184/JsmW9UZc=;
 b=eVZiBs8jQ6BJ35qUekDErfLN3to5cC7IiBcYe/JMLfliwMzdCktN3LLzKoPju3gF2M
 fT3PScuRgYtvpSrTDW9qkxEcIZavo5uZ8O49l5VC92t0IKttweNn3ttSUhQZ7WZ2NkBK
 fUgyWx4nQgQhPba+J2kCq1WlFiCFc2Io4diTjq/nc2xdKyvbUKqpmXdDMUKBEQyVQYBQ
 aRnR8fSV0nFDOqYTyKTGMr4g52fH1opwhhKNICddRPEZW8nUYAEynTXNQ1J2J3VE7vpz
 cH8iKc/I4KgDavBz8h6vy/lesCA+b+x4XyeGiQYyCVs+qnRIGna20OmVWqtU2u6r/h2E
 WYFQ==
X-Gm-Message-State: AOJu0YzsznGG/eswJW1xCDD2huUpLkKEvjGrmwK9735AEclEJ2bUWgJw
 M/T/F8m5Q8u/ryHZB2mzFZf9vqcT9C/KmEyw503X43ZfvqOCEXLJK8L7x1yGAOtmhk5j0kKYQmm
 kQqcIMP8Q+TMOu/3zVkqlsUJtpqlOE/Cn8r2CxVxHianFGgokpYWFjfL3
X-Gm-Gg: AY/fxX7UXJSW5aIGkKpzWsmYTCFpKM+4u/g821mr3uyvA/Nb9h29yc5mM0jvDLoXXRI
 QSJ5WBdTE0t/uL7kXxDhQyAB4qZKJprU2CiVMiCrMzUL2sHj8EARRdA/uX4gFMjfxtDKXYM25eP
 PzLlleirtKqOInVCkmm7TyzpaU58rxUHaL3bSEYBMEnQwkG6k8a/LkFPh3iChokMzGnQkUAfInp
 qDKuBqEV4C0zSMBhqkQrBvcoZtYUY7sC8xqrfyRqfLwX7R6LbHo9Geh4cZhGL1l7VOihcHpQY76
 Wm2uCHUY9u+vY9csyokkgNxMRC9gGvnpyP8BTyAo+nsKPGNVQvj7lor/9FlKJZVV0gmjrr8cIEq
 EnRA=
X-Received: by 2002:a05:620a:1791:b0:8b2:6a4f:ba70 with SMTP id
 af79cd13be357-8c37ebdc4dcmr117441885a.76.1767647023156; 
 Mon, 05 Jan 2026 13:03:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERBFydtNkGQ9I2PCSoZzT5vCKXKmQWNEcFVIp5ymGNot4Ujd+4T7aIZ+GWrZCSUFMcvy711g==
X-Received: by 2002:a05:620a:1791:b0:8b2:6a4f:ba70 with SMTP id
 af79cd13be357-8c37ebdc4dcmr117439085a.76.1767647022730; 
 Mon, 05 Jan 2026 13:03:42 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4b92a0sm31238885a.13.2026.01.05.13.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:03:42 -0800 (PST)
Date: Mon, 5 Jan 2026 16:03:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH v2 22/25] migration: Free cpr-transfer MigrationAddress
 along with gsource
Message-ID: <aVwnLQ-4Hp8NGdbR@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-23-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-23-farosas@suse.de>
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

On Mon, Jan 05, 2026 at 04:06:39PM -0300, Fabiano Rosas wrote:
> When setting a callback on a Glib source and giving it a data pointer,
> it's natural to also provide the destructor for the data in question.
> 
> Since migrate_hup_add() already needs to clone the MigrationAddress
> when setting the qmp_migrate_finish_cb callback, also pass the
> qapi_free_MigrationAddress as the GDestroyNotify callback.
> 
> With this the address doesn't need to be freed at the callback body,
> making the management of that memory slight simpler.
> 
> (also fix the indentation of migrate_hup_add)
> 
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Cc: Ben Chaney <bchaney@akamai.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


