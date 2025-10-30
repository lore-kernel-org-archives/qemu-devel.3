Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43CCCCF9F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEP3U-0005zJ-6K; Thu, 30 Oct 2025 05:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEP3D-0005sg-Al
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEP2i-0006R5-87
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761816835;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2HBGjsYLbW8d1DNqn760w0LCGloW9To/NkLIh4s+Zg=;
 b=gChA9HH9zJG9cv4uzIoeyL/TKK0WwIRcx6ijg/E8AiRNHGrjGBCSKYyxHx0HBIdK/0CwIs
 cOKtkap0OcUngQRhrzuMkHXR+nlxi4yRET5aqLvWp/6JEl81xsxJhe0OnuyvZguRYvUeH8
 9gcXacyai6GR0LO+UnCOsRuq0nsCiqQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-nKJqU76KOO6HApU1jdb9zQ-1; Thu,
 30 Oct 2025 05:33:51 -0400
X-MC-Unique: nKJqU76KOO6HApU1jdb9zQ-1
X-Mimecast-MFC-AGG-ID: nKJqU76KOO6HApU1jdb9zQ_1761816830
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3EBA180AE12; Thu, 30 Oct 2025 09:33:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA9C419560A2; Thu, 30 Oct 2025 09:33:47 +0000 (UTC)
Date: Thu, 30 Oct 2025 09:33:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Amit Shah <amit@kernel.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] scripts/vmstate-static-checker: Fix deprecation warnings
 with latest argparse
Message-ID: <aQMw-AO720PNFzWW@redhat.com>
References: <20251030092638.39505-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030092638.39505-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 10:26:38AM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The argparse.FileType() type has been deprecated in the latest argparse
> version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
> functional test to fail since there are unexpected strings in the output.
> Change the script to use pathlib.Path instead to fix the test_bad_vmstate
> test and to be prepared for the future when the deprecated FileType gets
> removed completely.
> 
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/vmstate-static-checker.py | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

AFAICT, using pathlib.Path should work going back to any old python
versions we would need.

> 
> diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
> index 2335e25f94c..89b100e6cca 100755
> --- a/scripts/vmstate-static-checker.py
> +++ b/scripts/vmstate-static-checker.py
> @@ -21,6 +21,7 @@
>  
>  import argparse
>  import json
> +import pathlib
>  import sys
>  
>  # Count the number of errors found
> @@ -382,10 +383,10 @@ def main():
>      help_text = "Parse JSON-formatted vmstate dumps from QEMU in files SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions would break based on the VMSTATE information contained within the JSON outputs.  The JSON output is created from a QEMU invocation with the -dump-vmstate parameter and a filename argument to it.  Other parameters to QEMU do not matter, except the -M (machine type) parameter."
>  
>      parser = argparse.ArgumentParser(description=help_text)
> -    parser.add_argument('-s', '--src', type=argparse.FileType('r'),
> +    parser.add_argument('-s', '--src', type=pathlib.Path,
>                          required=True,
>                          help='json dump from src qemu')
> -    parser.add_argument('-d', '--dest', type=argparse.FileType('r'),
> +    parser.add_argument('-d', '--dest', type=pathlib.Path,
>                          required=True,
>                          help='json dump from dest qemu')
>      parser.add_argument('--reverse', required=False, default=False,
> @@ -393,10 +394,10 @@ def main():
>                          help='reverse the direction')
>      args = parser.parse_args()
>  
> -    src_data = json.load(args.src)
> -    dest_data = json.load(args.dest)
> -    args.src.close()
> -    args.dest.close()
> +    with open(args.src, 'r', encoding='utf-8') as src_fh:
> +        src_data = json.load(src_fh)
> +    with open(args.dest, 'r', encoding='utf-8') as dst_fh:
> +        dest_data = json.load(dst_fh)

This could be

 src_data = json.load(args.src.read_text('utf-8'))
 dest_data = json.load(args.dest.read_text('utf-8'))


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


