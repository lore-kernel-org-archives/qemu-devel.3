Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE16CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZTh-0004To-Jq; Fri, 02 Oct 2026 05:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZTf-0004TN-E1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZTc-000612-Pu
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932967;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AqB2LOZkrCwbmpkKwKjjoZBMftnU9w2l3FL1sB8d2WI=;
 b=Htg1G6hyj+T+oSyLajseWFSFZIo+uBQjtRZwLzcmwbUIgeMHKMTp/V3bxT09gt6KBx0WtB
 Z8RNOc1rQTMEmsgIExJ/YugVA0vDMS+XmEvVSvgpa1Yi7lzmq3Axy8bCQ4f4KKWyrL26TO
 Gz1+9/sjSLNm1ANpfkaKw3s+dUnGRaU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-x5_rz-A3Pn62RAAI4PY8iw-1; Fri,
 02 Oct 2026 05:22:45 -0400
X-MC-Unique: x5_rz-A3Pn62RAAI4PY8iw-1
X-Mimecast-MFC-AGG-ID: x5_rz-A3Pn62RAAI4PY8iw_1790932965
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3ACB184AE52
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2026 09:22:44 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88E09756; Fri,  2 Oct 2026 09:22:43 +0000 (UTC)
Date: Fri, 2 Oct 2026 10:22:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 18/20] trace: stop tracking static disabled state
Message-ID: <ar934CPHs5HlIo4P@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-19-berrange@redhat.com>
 <179088207684.2348671.5166153170222056421.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179088207684.2348671.5166153170222056421.b4-review@b4>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 01, 2026 at 11:14:36PM +0400, marcandre.lureau@redhat.com wrote:
> > The TraceEvent struct contains a "bool sstate" field which track whether
> > a trace event was disabled statically. i.e. at build time via the
> > "disable" property annotation in trace-events.
> > 
> > The only runtime use of this field is to let "trace-event-get-state"
> > report that an event is "unavailable" instead of reporting an error for
> > an unknown trace event.
> > 
> > Trace events are not ABI so their names can change and the event can
> > come and go at any time. Thus there is little utility in reporting the
> > existence of a disabled event that cannot ever be used at runtime.
> > 
> > Removing the "bool sstate" field from TraceEvent saves 8 bytes of
> > space in the struct, adding up to approx 64 KB across all current
> > events.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-ID: <20261001151228.3373747-19-berrange@redhat.com>
> 
> Need a tracing.rst documentation update too.

I'll do that docs in the next patch, since that is the
one that actually removes the functional part of the
feature.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


