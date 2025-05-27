Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284C3C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtwa-0005I0-8T; Tue, 27 May 2025 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJtwY-0005Hf-9T
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJtwQ-0004fK-Tr
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748350912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJP2qYwGmw3Y23WHWlj+mKFOZl0tTVZVIHqTLgIwQFc=;
 b=RaRLqaQevkRiHh8Qg+YesP8xm15gb2s0Lq3gfnYp9Y56zFW8gP4rmS+Lavv3hdFJVPmvkT
 A9hA8CDupO29HZZpX0A7eY2shx7K9z5jTwYks8KEPQnfV0mC0gO1gWIirGY9xJs4AWbni5
 DzxlgEV88XV6id4OrV2vArWNLzUkxFE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-xYe_iVnaOnmLNDL9FjNXEQ-1; Tue,
 27 May 2025 09:01:19 -0400
X-MC-Unique: xYe_iVnaOnmLNDL9FjNXEQ-1
X-Mimecast-MFC-AGG-ID: xYe_iVnaOnmLNDL9FjNXEQ_1748350861
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38E8F18007E1; Tue, 27 May 2025 13:01:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E39D418004A7; Tue, 27 May 2025 13:01:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DE9321E675E; Tue, 27 May 2025 15:00:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 00/15] qapi: remove all TARGET_* conditionals from
 the schema
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 22 May 2025 12:05:27 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
Date: Tue, 27 May 2025 15:00:58 +0200
Message-ID: <87frgqnr79.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series exposes all qmp commands for any target unconditionally, allo=
wing to
> compile QAPI generated code without any TARGET conditionals.
>
> Based on original RFC from Daniel P. Berrang=C3=A9:
> https://lore.kernel.org/qemu-devel/20250508135816.673087-1-berrange@redha=
t.com/

I picked a few nits.  I'm happy to address them in my tree without a
respin.  If you object to any, please let me know.

Series:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


