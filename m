Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBF5C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCf6y-0001nu-Kl; Thu, 30 May 2024 08:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sCf6s-0001n8-Mv
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sCf6r-0001PK-1x
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717072940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TdQd7rrUtARv9JDe5r9L+gVrcn56YkzAsGYcVpPSeeQ=;
 b=Sn/bzXchbrgxeIFm6N3ctEl4HkmyXwlQqFJh8y93Qn8CokPuYptLSQNeChXVGLh8VPJK9q
 Jqu/CzMfTmm3hOC+ups+z8/2c5FMetbaS9pSOQY0UsOkgrbDYio6o+7SsVpPYg+CobbxrJ
 qB3M5w4WwvNlYy/l8lSzW0k4meyWCQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-We-dcFiXMCGoaxow2Qbejw-1; Thu,
 30 May 2024 08:42:16 -0400
X-MC-Unique: We-dcFiXMCGoaxow2Qbejw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 636C61C05122;
 Thu, 30 May 2024 12:42:16 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C71491032;
 Thu, 30 May 2024 12:42:14 +0000 (UTC)
Date: Thu, 30 May 2024 07:42:12 -0500
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/4] qom: allow to mark objects (including devices) as
 deprecated.
Message-ID: <bxlnnqd25wdd5qg5utqcruu3yeg5hi3k6jpfc7iodndty3d5qd@4bu7fvfttf3g>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530112718.1752905-2-kraxel@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 01:27:14PM GMT, Gerd Hoffmann wrote:
> Add deprecation_note field (string) to ObjectClass.
> Add deprecated bool to ObjectTypeInfo, report in 'qom-list-types'.
> Print the note when listing devices via '-device help'.

In the subject line, I suggest s/allow to mark/allow marking/

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qom/object.h  | 1 +
>  qom/qom-qmp-cmds.c    | 4 ++++
>  system/qdev-monitor.c | 5 +++++
>  qapi/qom.json         | 4 +++-
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


