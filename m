Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6576CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00e-0001Oc-5P; Sat, 17 Oct 2026 04:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00T-0001Mk-BW
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00R-00078t-OV
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBPZ3+gr8j7J2swfT2jwuGQhyIHFObtR6lQpKaKvrVQ=;
 b=Qy6LBs8LNyLNzgO/eKq4tx6Bh7SFlBkG4z8iPu+w0cD0ZxsP5osiihZSPalOCiQ0jrJUjr
 gEZ2q8wcJxdwAcyRABkwWoyVsqlmMlaOASxskvDvtF+y16jZSiFxOsRUE14RqhWbbZpT9I
 vkDzTnKnRuoEd09ZYCPygIugY6xlsW0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-6LyfeaTkM6GhkH8VfD-pNQ-1; Sat,
 17 Oct 2026 08:43:02 +0000
X-MC-Unique: 6LyfeaTkM6GhkH8VfD-pNQ-1
X-Mimecast-MFC-AGG-ID: 6LyfeaTkM6GhkH8VfD-pNQ_1792226581
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 572A91800766; Sat, 17 Oct 2026 08:43:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EF81195608A; Sat, 17 Oct 2026 08:42:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 02/23] dump/dump: do not dump machine if doing
 heterogeneous emulation
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-3-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-3-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:48 +0400
Message-Id: <179222656891.1619676.15516600776418162728.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=454;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2FB5esz+OrHwRQ4mJgyWx0rMGFeN87KrLktYQOc8K+I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUMvmoXLYXKVe0Nc7G5pdhjRSccyMYf2fWoL
 sfUl/p9WpqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5ZvsD/4zQBHEkm/nG4vp55fesVopuXovQbxcyeLIkp3TIC0Uarz5ewpsMUT+nrYyIf1nxxMPZus
 KNOZDocyFH70PYWJmtn25Jysr3cWeA7yWtcC3l22XjmbKPlZxV5Cp3H/aRrGBZYkggniedvBkkr
 7xi+xdLGOhFKCanb2nrp258MX3UEjR23xtEzEvtWgGASh2/On/eZF5UweIx42akBqSSAWxALfmv
 UpphDpXwgXQV9vkO2PBKWIJqvohb0rQbdDn+2tnSu+YabtQzhROPXaf4HfJsUpG7p+G6xzX2dFz
 JQwgAEuBL1zsv5gAtTl5NEaFLVlzO0g4tXxgkwc8kJtjR8+n9tygWIa+0r7eFLZJJtN9LdEJRQU
 hjoPo9PD31waHJkyGLzgMw/4j/OlxJJRxNpH3RkA30q+/ZJ9M6H6uArbL1BmeEhzaYMbSfV3vJE
 yEeTKr/7RZ+nq/AStjkpFf2Ml+PHwqW0MqJoRacI9tiKtFeMpMAUOfqBxpLO1EctN8sZ2S2d4da
 FdP6dBIO63qKWzUCg+oAacnQVN/VgUYZ8PbKkhFPJwloWgNMx5F8cHZzoF5TWdt+k+c4xch/YnB
 tCeEh4igWdOY96vnQrFzaluqCUSghNefd0k3TB6pORBAPUteG3jBc7ZI5eqtH/V0PD58uNRwFGP
 udK0MAidvwQZkYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 16 Oct 2026 11:13:49 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> This would need some refactoring to do it correctly over all targets
> involved. For now, simply prevent this from happening.
> 
> We do the check at beginning of function, so no need to call cleanup
> routine.
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


