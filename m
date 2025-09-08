Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766AFCAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf2g-00015z-3Y; Mon, 08 Sep 2025 12:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf2e-00015O-IW
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf2P-0000h6-Uz
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350075;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6d3Mi9A8H+LceKAUJU5ujkgMm555a65vPUme2SBiZkI=;
 b=OAkUEb2mKonweuuO8TikLzgKRai7NPK7akFdCJVwL3RfoIu7Fs/9n1NeusJdqDYiDvlK2Z
 S0fkVWaf5tSioIzl4PIFHf24IKXZZliJaN99PyT7Y7xnh8tHybLA0NUQK8KAQGiwGpX7NL
 oodU2aGK8xNFVozsmkdhZLhzVPZ3SMk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-YAc01YmJOauurepaPhLQsg-1; Mon,
 08 Sep 2025 12:47:52 -0400
X-MC-Unique: YAc01YmJOauurepaPhLQsg-1
X-Mimecast-MFC-AGG-ID: YAc01YmJOauurepaPhLQsg_1757350071
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 838C61800366; Mon,  8 Sep 2025 16:47:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5683B19540ED; Mon,  8 Sep 2025 16:47:49 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:47:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 06/18] python: backport 'qmp-shell: add common_parser()'
Message-ID: <aL8IsV55wwhSxSeu@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-7-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903051125.3020805-7-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 03, 2025 at 01:11:12AM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> cherry picked from commit 20a88c2471f37d10520b2409046d59e1d0f1e905
> Signed-off-by: John Snow <jsnow@redhat.com>

Duplicate s-o-b

> ---
>  python/qemu/qmp/qmp_shell.py | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)

Wierdly the diffstat when I looked qmp_shell.py is very different
from what your patch here shows, but the end result appears the
same. Perhaps one of us has different settings for $HOME/.gitconfig
that affects diff display

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
> index 98e684e9e8a..02028e94b5a 100644
> --- a/python/qemu/qmp/qmp_shell.py
> +++ b/python/qemu/qmp/qmp_shell.py
> @@ -514,21 +514,27 @@ def die(msg: str) -> NoReturn:
>      sys.exit(1)
>  
>  
> +def common_parser() -> argparse.ArgumentParser:
> +    """Build common parsing options used by qmp-shell and qmp-shell-wrap."""
> +    parser = argparse.ArgumentParser()
> +    parser.add_argument('-H', '--hmp', action='store_true',
> +                        help='Use HMP interface')
> +    parser.add_argument('-v', '--verbose', action='store_true',
> +                        help='Verbose (echo commands sent and received)')
> +    parser.add_argument('-p', '--pretty', action='store_true',
> +                        help='Pretty-print JSON')
> +    parser.add_argument('-l', '--logfile',
> +                        help='Save log of all QMP messages to PATH')
> +    return parser
> +
> +
>  def main() -> None:
>      """
>      qmp-shell entry point: parse command line arguments and start the REPL.
>      """
> -    parser = argparse.ArgumentParser()
> -    parser.add_argument('-H', '--hmp', action='store_true',
> -                        help='Use HMP interface')
> +    parser = common_parser()
>      parser.add_argument('-N', '--skip-negotiation', action='store_true',
>                          help='Skip negotiate (for qemu-ga)')
> -    parser.add_argument('-v', '--verbose', action='store_true',
> -                        help='Verbose (echo commands sent and received)')
> -    parser.add_argument('-p', '--pretty', action='store_true',
> -                        help='Pretty-print JSON')
> -    parser.add_argument('-l', '--logfile',
> -                        help='Save log of all QMP messages to PATH')
>  
>      default_server = os.environ.get('QMP_SOCKET')
>      parser.add_argument('qmp_server', action='store',
> @@ -564,16 +570,7 @@ def main_wrap() -> None:
>      qmp-shell-wrap entry point: parse command line arguments and
>      start the REPL.
>      """
> -    parser = argparse.ArgumentParser()
> -    parser.add_argument('-H', '--hmp', action='store_true',
> -                        help='Use HMP interface')
> -    parser.add_argument('-v', '--verbose', action='store_true',
> -                        help='Verbose (echo commands sent and received)')
> -    parser.add_argument('-p', '--pretty', action='store_true',
> -                        help='Pretty-print JSON')
> -    parser.add_argument('-l', '--logfile',
> -                        help='Save log of all QMP messages to PATH')
> -
> +    parser = common_parser()
>      parser.add_argument('command', nargs=argparse.REMAINDER,
>                          help='QEMU command line to invoke')
>  
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


