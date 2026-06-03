Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19489CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUn5s-0003Wo-UW; Wed, 03 Jun 2026 11:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wUn5p-0003Vx-RI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wUn5o-0007xh-BH
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780498870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bvniaCVNmviiUSPLz7WGQNnnLnUIllo01jx/5iY+Ag=;
 b=HiYORUrkLo4QAsQ45DkbmVglphHrj6dMlVt/VOPoIiQvNWpqkDg8XbQOgfPqucNREvXe69
 6qvzYK8L2vIHd15mo3WeLrJvVAzkwY0puXZ2iQ48v3HfiwQNWF94CAWjSTO6QbruKUfdpK
 RQFVo1yS0ggT6oUzs+YXTaHvfDeMuhU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-f3eUoKEpMyqVL4as2_TkYA-1; Wed,
 03 Jun 2026 11:01:06 -0400
X-MC-Unique: f3eUoKEpMyqVL4as2_TkYA-1
X-Mimecast-MFC-AGG-ID: f3eUoKEpMyqVL4as2_TkYA_1780498865
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A69E1956096; Wed,  3 Jun 2026 15:01:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1F38195E483; Wed,  3 Jun 2026 15:01:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 04/13] system/ram-discard-manager: implement replay
 via is_populated iteration
From: marcandre.lureau@redhat.com
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
In-Reply-To: <288eac74-0eb8-4aa6-8238-0fc00e1e50e7@kernel.org>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-4-bdf61e57c1e1@redhat.com>
 <288eac74-0eb8-4aa6-8238-0fc00e1e50e7@kernel.org>
Date: Wed, 03 Jun 2026 19:00:56 +0400
Message-Id: <178049885621.2481790.7272980124227926188.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=800;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yocCG3osjy2zQVUvBE8aZWdx7Ar7NepnX6k1//LqTsU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIEGoNGP36sHTkY1XpyOwBzYLLSthWm2RnIBWG
 ABBxCaLaKWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiBBqAAKCRDa6OEJdZac
 5TBvD/4pqcIpaQHZ0FuyMTl5+DSD9r0qJc6KT1JxZW9CWwYmLO+I4bY3HPfALK5W34WX1kqC/m9
 p4cayz7/7yPrzFxN4Mn/I0nLSTFLol0JI039X+dAIo2ODBE18449/3aIZPaRLOfucg7Fh/VkKGP
 6sf94mK0qRoRgZFkOLoI+GZw4y0LMEgZEqtJ1Y2dclLLoKm8xD54Z5Sz9V19Xv7rzV53tNuXG/9
 RdGED6SYRakeMs3wOiP35BEeSsU0H9Sed+UlU9M3CSPbsAdFJP1Ybx+tPM8HkHaHkHdJgCZHlaK
 JnKe99VvAZUGz1k/8+NuvEk+x2x7bALMM9g02/S+vjAOARVBYCHWM3i0MCtMZFyBw4QfKuGHJld
 5nhjdIVfEEQmAet36MtWKps70rF5yh6bbNS8eWN92OYMXJt80zKYx4c9rhOdii5qrqBlIrgnCa8
 qZuna7z18GTfW+Ih+mRaznV/xXvj9OAjCYY/q2hp9QuYgthYHOnJR+N+zTcxvrh8NBJJStsNB5J
 vHAkKYJKzi8pIKLAbzo3HvbyJgGgfN/iCHkYhencs7hy/4G0E0DPhO0a5J3qB89kU1NVR9DuXTZ
 4Wk2dmAxR4hgYljFUNfWAvXzFZM/bpGTPIqD5k7AKPB/QfB+md/udtIcwN3Bh8kqvfOc4otGsnj
 XEEOeagfu7CmDuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On 2026-06-02 15:37:38+02:00, David Hildenbrand (Arm) wrote:
> On 5/4/26 14:30, Marc-André Lureau wrote:
> 
> > -        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
> > -                                                  rdm_populate_cb, rdl);
> > +        ret = ram_discard_manager_replay_populated(rdm, rdl->section,
> > +                                                   rdm_populate_cb, rdl);
> 
> I'm probably missing something. You are changing the parameters passed to
> ram_discard_manager_replay_populated(), but
> ram_discard_manager_replay_populated() is not actually modified in this patch to
> take other parameters?

We are switching from calling RamDiscard "Source" replay() to RamDiscard
"Manager" (with a single source for now).

thanks


