Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16B4CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waG9S-0000r7-IW; Thu, 18 Jun 2026 13:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waG9J-0000qQ-4N
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waG9H-0000Ln-7d
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781802205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kz3meVQ3Um7lZZANp3ZTfmS6FbLcauLy3/log9/kVIM=;
 b=KEaBNtfZ1x1KfsvUn8zAEU0fbWQmbinAZyoD5mOed9x+7H6aiG+6XeX8X7AX52QK4mAYkm
 AyFR/TjIW9DrMgSXVieOPRs2TmhblLt3BdoJA/UOcoDsERVUWN2M7FQ9xOSBGlGSUWuWXc
 0zRQ8gSBUkBnTaxR/hecCSgnrYYqKI0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-O34ie0R9NvOjokXF3C7OYQ-1; Thu, 18 Jun 2026 13:03:23 -0400
X-MC-Unique: O34ie0R9NvOjokXF3C7OYQ-1
X-Mimecast-MFC-AGG-ID: O34ie0R9NvOjokXF3C7OYQ_1781802202
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46011aa5000so700643f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781802202; x=1782407002; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kz3meVQ3Um7lZZANp3ZTfmS6FbLcauLy3/log9/kVIM=;
 b=uMR2Wv4j+umxcpqaMYlkAFJ+9lZdvL6BxhHtRhrVn0GLg28HJCO9W/yJ0tVtR/1h9W
 cnq1FVtGEj+ZsuoetJaVq4qu9KVA4gfucFSNepo+LoJTPfWaxexWThjOyoD3jFBhbVuT
 xplmvlYwWE8VgBMt6TRgKIwDwWthz+DEsFFMG/VeIMvGQ+nw5u5eLpimBkePHRActwKn
 +GB6h6YIB5yBT8OdFPemlc0mfpfUM1VDtokMfHP/nXbfey65u6EFD1dTALv66laVZsYc
 0MzpYl/Y8RMR/EKwCnIuzFBsn1OPD+3PG35bS16a+BH6O5cu1zU0xsvcAFq3CAsFanSF
 okhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781802202; x=1782407002;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kz3meVQ3Um7lZZANp3ZTfmS6FbLcauLy3/log9/kVIM=;
 b=fkrZ6XkiGQ/rxuAG8NsyjmSyyQphqsBAn+zDrn9FuyFhWWaPTVm7CsSQtR9Asc44lA
 oVDvl+MlYJ6JInoBXtFHNWY8xmEvLt1Kj4kzSMQjWaNG7Z6KHmYoaGPsF0e3BsIPSQRX
 Zgdpr+a6G+HUtdWAC2bPcMAtmF0HZzOGC50YD22nthOjbr1+JWhjNlmAHd1s3qeRIgCe
 Axl69rI4JNXKDpE39FQQBOa2mTq2R3bnzluH74Uaq0Rjb9N7km8nPdjY3Hb7NWv+RnJL
 ASc1qvVJrZ7LVu2FHwJJ/TsypLa3xWyBlA9t3+FKtBPmVaKY/8wZvybRY18vvTfFabnP
 zKXQ==
X-Gm-Message-State: AOJu0YxPp86vgxIxrw+QDUePa0i8xgvw6B6dS8rEuEmPZv2tn+uLtXDt
 ZQiSqKiLDyGRciq2Nk+uRm5gToBx0GaMu/zkgS9cmP+iBO+Ksw8mITE33lLOF+Abkn4uV9/NAVG
 mNJw8PLoRtWFnynxcApOD1OOpg2e9e78Xueoyxb6mRVKWVqvQEDA5e85t
X-Gm-Gg: AfdE7ck+mvcf8QG9sSLrtajQxLy4Dgrqap+2GnGAfuOZqYKqWUFyxnLcfZgAtqEDkRo
 ve5Y1mFVqVoywTqm3ItNFr0vO8Z1/65hLz3czSYbt0EfbkrqR0Q3s2dJYhCDsKUNxwzQGA7Ot/0
 i1CHur44hoqC3HYmu0MDXqqwm2T+e1GZR5W1ItOKmCFfvghg9Mst8v4hxipJHZQedsO5Su1yhT9
 0ZMUEL63P04mOGEIYm2TQxc5gZXBns6pT3DXeYqvsTZYopP9A8mEZQzAYx0Q+5TqBnAmhfC3AWN
 2dc8PXaeYMA+utz1KGj3RtTFmtIsnz8qYNitzT38uGaaq7I4K1FohjJaircH9ke1rysm1oEYK4A
 +hmkslflEbHnmj06szcVqRNV7l4QaLF6F
X-Received: by 2002:a05:600c:c4a6:b0:490:bb37:9d49 with SMTP id
 5b1f17b1804b1-4923f1530c5mr7144735e9.11.1781802201833; 
 Thu, 18 Jun 2026 10:03:21 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a6:b0:490:bb37:9d49 with SMTP id
 5b1f17b1804b1-4923f1530c5mr7143475e9.11.1781802200755; 
 Thu, 18 Jun 2026 10:03:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46508a04d22sm354345f8f.8.2026.06.18.10.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 10:03:20 -0700 (PDT)
Date: Thu, 18 Jun 2026 13:03:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <20260618130219-mutt-send-email-mst@kernel.org>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618112415-mutt-send-email-mst@kernel.org>
 <ajQXrpKNx4NnhUKa@redhat.com>
 <20260618121520-mutt-send-email-mst@kernel.org>
 <ajQd8nRuYau2xVcY@redhat.com>
 <20260618123451-mutt-send-email-mst@kernel.org>
 <ajQjCHvJTqpvPzqz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQjCHvJTqpvPzqz@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 18, 2026 at 05:55:36PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 18, 2026 at 12:39:31PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 18, 2026 at 05:33:54PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Jun 18, 2026 at 12:23:46PM -0400, Michael S. Tsirkin wrote:
> > > > thanks! sorry probably just me being dense but some things
> > > > here I don't get. might be worth clarifying:
> > > > 
> > > > On Thu, Jun 18, 2026 at 05:07:10PM +0100, Daniel P. Berrangé wrote:
> > > > > On Thu, Jun 18, 2026 at 11:30:29AM -0400, Michael S. Tsirkin wrote:
> > > > > > > + * The maintainer(s) will develop and/or review patch(es)
> > > > > > > +   for the issue privately, optionally attaching work in
> > > > > > > +   progress fixes to the GitLab issues.
> > > > > > 
> > > > > > attaching how? how do i ask reported to test the fix?
> > > > > > was easy in the email flow.
> > > > > 
> > > > > You can add arbitrary attachments in gitlab issue comments.
> > > > > 
> > > > > > > All patches must
> > > > > > > +   include the issue URL in the commit message(s).
> > > > > > 
> > > > > > you mean the commit message of the patches I presume?
> > > > > > there's no commit at that point.
> > > > > 
> > > > > Well I presume the maintainer will have a local git tree
> > > > > with a work-in-progress commit.
> > > > 
> > > > sorry I don't get it.
> > > > 
> > > > what does it have to do with patches then?
> > > > 
> > > > 
> > > > who cares about my local tree?
> > > 
> > > If you fix a gitlab issue, the commit must contain the issue URL.
> > > That's normal practice we've followed forever and would now apply
> > > to security fixes too.
> > 
> > Ah. You want a Fixes: tag maybe? Let's say so pls then.
> > 
> > > > 
> > > > and why is this mentioned twice?
> > > 
> > > Mentioning twice is a mistake
> > > 
> > > 
> > > > > > > The
> > > > > > > +   **"Workflow::In Progress"** label should be assigned when
> > > > > > > +   a maintainer starts working on a fix.
> > > > > > 
> > > > > > That's a bit heavy, and what is "working" anyway.
> > > > > > It's an issue tracker not a planning app.
> > > > > > Don't try to make it one.
> > > > > 
> > > > > Various "Workflow::" labels are already present in our gitlab
> > > > > instance. We don't use them consistently - this text is just
> > > > > a pointer that the're there.
> > > > > 
> > > > 
> > > > maybe "can be assigned" then?
> > > 
> > > Ok.
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > + * When a CVE is allocated, it must be recorded as a comment on
> > > > > > > +   the GitLab issue, and the **"CVE::Required"** label replaced by
> > > > > > > +   the **"CVE::Assigned"** label.
> > > > > > 
> > > > > > Recorded as a comment how exactly, in what format?
> > > > > 
> > > > > In plain text.
> > > > 
> > > > yes but in what format?
> > > 
> > > Literally just  "CVE-2026-1234" anywhere in the commit message as we've
> > > been donig for years.
> > 
> > I suspect what we've been doing for years no longer scales or
> > we'd keep doing what we've been doing?
> > 
> > 
> > We desperately need something that is consumable by tooling,
> > and I just do not see how is a tool going to figure out
> > "this seems to be unrelated CVE-123" is irrelevant.
> 
> It depends who you mean by "we" here ? From an upstream POV I don't
> think we care. We ship fixes in master.

Why do we bother with CVE numbers at all then?

> While it would be nice to
> have stable releases with all security fixes backported, we have
> never promised/offered that and with the volume we see, I don't
> think we should try to add such a promise either.
>
> IOW, consuming CVE fixes is largely a downstream problem. I'd
> recommend they start from the gitlab issues with Kind::Security
> and CVE::Assigned tags present, but beyon that its upto them.

Let's say they do it, how do they know the CVE number?

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


