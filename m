Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB59CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00j-0001QS-08; Sat, 17 Oct 2026 04:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00h-0001QD-I0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00g-0007AH-4X
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUTSALC0Ypxkbk/y/lS5miWnz/DYRDhZpVyhsoOtcGg=;
 b=ev27hmjMu/1dEUXqWgsgBxwhScMmTgsSBqxBwLDSqQFdowtx12ZN/xAJ231s+DSNocxgMk
 0C3Qliby7mpD73KWqfOpwK/IFtH/VrHRg5ZRZWR01tDhXYYHHKq6im09ogUN2dQzHvEa70
 vL/mOducK6iv9gLbH9TEfkJRugOl1+c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-_qHj7r2kPeqqB2cHumY1iw-1; Sat,
 17 Oct 2026 08:43:17 +0000
X-MC-Unique: _qHj7r2kPeqqB2cHumY1iw-1
X-Mimecast-MFC-AGG-ID: _qHj7r2kPeqqB2cHumY1iw_1792226596
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C5B41955E82; Sat, 17 Oct 2026 08:43:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10F941956089; Sat, 17 Oct 2026 08:43:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 06/23] target/arm: implement get_dump_info sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-7-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-7-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:48 +0400
Message-Id: <179222656896.1619676.13393137283006176094.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mes9TRhAGZdTK0qUncDuGxQ36CqI2pH8GGqiIEXzuuc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUMwyAT06/mUK+wioHLtIdMvnnYkqd+P9MEE
 5DbeQ7JZN2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5RY4EAC5zTjnyusn+c0ovfkXlyHtkOMZyMQfanAA7CnKmqCo1a+Fk8cYj7+ZR+cuLQFjTHFwXPd
 Ap3h/oVHe3Cy2Lp+gEwetygUvsd3LD/LsH6GAbmqJt7pvGuFNB2q/3tJ5XqbKwdqZP3Ww4U9sYl
 n7TvSTf35VPgqE01TnPeU5TK96iOCwCjbDGuXjI77szap32IyQvP2FYILzB8TKZHrTW4ei4X1PI
 j359ttwDJp3j6XcT6iMk6dLVvQ8yLvHWTKJqt5vihWGrU8Ab6pe7on1EdVhFxui7h9cwP3eNgba
 nURnaJGtweuj12U+CzVv7DSAizEZ/1YaWFu6P7SrqnlnPchSXH5oVWISHVofBo1Fdk2xK5WwPjU
 pS3oJAp2jK9EIzlqMlWmhFUOv+Sd05Au3KgEkSnaHqhgDqIUlCDwCWXAsYahhtYaYpfg/xsc3fo
 Lsvi7PQHUhz1ebgLtc2sOyk4RhdvTW0mEBIjQAy2WAfwMHz0aG4n/alMMhC6HbkgBbUKEewbCJf
 idyB8E42Gb74ulv5uOVC4UakRXAYo8wcjv9qlVdzMosutA/DQonw99QdoPfGckXwevhN8HsxJdD
 wBZHjGdc3xiwwWk7J0HqZkX7UQlrcENPLFyYKDy33BzsQF6scC+cjPW3rf471VhuwLJnj0MHmGE
 f+6QHGkjqHAZ5Yw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 16 Oct 2026 11:13:53 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


