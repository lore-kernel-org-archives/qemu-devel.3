Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06A0CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8v8H-0001ue-K0; Wed, 15 Oct 2025 02:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8v8E-0001sg-BF
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8v8B-0004oQ-Ev
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760510218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8jlYIehpraRXaRsN9VUHrlgM298EMBoMQNuYN2cSk4=;
 b=DO3Xo7R+gZcH/dutANi+1reLiBDPnuwWWRFtzGKqbYa/pGrJyt/yDowdxSj9svrCW9iw8E
 KwbXUr2JHCaHMVGWa+ESrzsYpcwoaVJrgV4xF4zQViCF4HfYG7Q0f+Rh4t/Wym1iodrBhT
 SDD5B2IdeuhrsnmR1e3iEDfvKiU7MPI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-e2JrQnAaM3-KTTwpeaCVlg-1; Wed,
 15 Oct 2025 02:36:57 -0400
X-MC-Unique: e2JrQnAaM3-KTTwpeaCVlg-1
X-Mimecast-MFC-AGG-ID: e2JrQnAaM3-KTTwpeaCVlg_1760510216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDD641800741; Wed, 15 Oct 2025 06:36:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12F781955F1B; Wed, 15 Oct 2025 06:36:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DC73A18000B2; Wed, 15 Oct 2025 08:36:52 +0200 (CEST)
Date: Wed, 15 Oct 2025 08:36:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 1/2] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <vhlcfuavvamzugm5okig6x5nrrqodkim3kqacr3h26xtcjadyv@zfexdtgwdfzl>
References: <20251013104954.250166-1-kraxel@redhat.com>
 <20251013104954.250166-2-kraxel@redhat.com>
 <87qzv5oflb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzv5oflb.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

> > +/* ----------------------------------------------------------------------- */
> > +/* qemu monitor command                                                    */
> > +
> > +typedef struct {
> > +    uint64_t             magic1;
> > +    uint64_t             magic2;
> > +} MEM_DEBUG_LOG_MAGIC;
> 
> You changed capitalization.  Intentional?

Reduce the qemu / edk2 code style mix a bit ...

> > +    if (log->log) {
> > +        g_autofree gchar *esc = NULL;
> > +        g_autofree gchar *out = NULL;
> > +        size_t outlen;
> > +
> > +        out = (gchar *)qbase64_decode(log->log, -1, &outlen, &errp);
> > +        if (errp)  {
> 
> How can this happen?

In theory it should never happen.

take care,
  Gerd


