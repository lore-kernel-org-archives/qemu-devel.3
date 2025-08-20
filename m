Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FAFCA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 11:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uogZ2-0001sL-0d; Wed, 20 Aug 2025 07:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uogYw-0001rp-FL
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 07:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uogYp-0006hm-Jc
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 07:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755687651;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q64uwQsFmlhB36xU+cKKx7TpMfUZ417PuFvOivLM6Pg=;
 b=Mxhk0GiGrMAY8T5E+n2iClWgCpI8Cne8iAp2fxl2rvAWVy/vKh5MyPE//KvAg8qqkvkLMa
 w5WZrlpM+iEris+PP/Z0SmsRrcpq2VWsLGFuc+aDL3qvukL0bvDjupswh7IaewXo8cR9It
 pUztN5jZ+EMcQufymZ2kxoDrMiljH6c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-fVw3SK3_OSS7Ye-xyuLo_w-1; Wed,
 20 Aug 2025 07:00:49 -0400
X-MC-Unique: fVw3SK3_OSS7Ye-xyuLo_w-1
X-Mimecast-MFC-AGG-ID: fVw3SK3_OSS7Ye-xyuLo_w_1755687648
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCD1E1800370; Wed, 20 Aug 2025 11:00:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A53719560B2; Wed, 20 Aug 2025 11:00:45 +0000 (UTC)
Date: Wed, 20 Aug 2025 12:00:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 07/12] util: introduce common helper for error-report &
 log code
Message-ID: <aKWq2uiCTN-Eo4ye@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-8-berrange@redhat.com>
 <bc2a7355-355f-4207-a0de-5a7b75fe3da9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc2a7355-355f-4207-a0de-5a7b75fe3da9@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 20, 2025 at 07:57:47AM +1000, Richard Henderson wrote:
> On 8/20/25 06:27, Daniel P. Berrangé wrote:
> > +char *qmessage_context(int flags)
> > +{
> > +    g_autofree char *timestr = NULL;
> > +
> > +    if ((flags & QMESSAGE_CONTEXT_SKIP_MONITOR) &&
> > +        monitor_cur()) {
> > +        return g_strdup("");
> 
> In the event we want no context, we really should avoid memory allocation too.

Yes, won't not be too hard to check for NULL in the caller.

> > +    }
> > +
> > +    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
> > +        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> > +        timestr = g_date_time_format_iso8601(dt);
> > +    }
> > +
> > +    return g_strdup_printf("%s%s",
> > +                           timestr ? timestr : "",
> > +                           timestr ? " " : "");
> 
> g_strdup_printf isn't the nicest string concatenation tool.

A GString would make it easier. Though typically that would involve
an allocation of GSTring struct, I guess we could be sneaky and stack
allocate the struct.

> And again, there's a no-context path.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


