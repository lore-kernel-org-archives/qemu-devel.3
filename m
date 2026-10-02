Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E5ACA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfdF-0001l9-Bd; Fri, 02 Oct 2026 11:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCfcy-0001kb-0T
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCfcw-0002cM-CI
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790956607;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lxM0S1OdEGuxby1pPC/MR8k0I8rdBH7C1kyWza0kjAc=;
 b=foyIfJ6BHktOpN78CNFIFDpaAA0du1wEFik8POudTV+Lx3jHVXT7vRAGy2OhN0fru4mghI
 MJlVetnUTdQaqpFL+a2t2spJ17wX7f5QccsjRuQGWtF78oMWjhplbQDkTHjEwEv33C+2Hz
 G/LlzlrwJyqAgeMzGfDFjuWB7Ka09fc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-evYbSGFBPFu3DkyDFI7xoQ-1; Fri,
 02 Oct 2026 11:56:44 -0400
X-MC-Unique: evYbSGFBPFu3DkyDFI7xoQ-1
X-Mimecast-MFC-AGG-ID: evYbSGFBPFu3DkyDFI7xoQ_1790956603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E44521800147; Fri,  2 Oct 2026 15:56:42 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33BA31800576; Fri,  2 Oct 2026 15:56:41 +0000 (UTC)
Date: Fri, 2 Oct 2026 16:56:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] Target-aware machine inventory in combined qemu-system
Message-ID: <ar_UNrabdtEM3pt_@redhat.com>
References: <CAE2XoE9X99kzBMWBo8rxmRGnT3NysHjf-GffC9X2796GGipUkg@mail.gmail.com>
 <CAE2XoE-_8jpRaPDE+uYYzszT38XpdB8JJJyXg51Z0-GD=4gMsg@mail.gmail.com>
 <24e1e361-5d4c-42cd-b715-963052aafe43@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24e1e361-5d4c-42cd-b715-963052aafe43@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 02, 2026 at 08:45:00AM -0700, Pierrick Bouvier wrote:
> On 10/2/2026 8:32 AM, Yonggang Luo wrote:
> > Now I place this RFC at https://gitlab.com/qemu-project/qemu/-/work_items/4635
> > Maybe there would be a better dicuss place if possible.
> > 
> 
> Let's keep this on the mailing list, thanks.

Agreed, we don't really use the bug tracker for feature requests
or design discussions.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


