Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB45C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGUI-00066S-SU; Tue, 18 Aug 2026 05:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wwGUG-00065z-Vw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wwGUF-000776-8b
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787046721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+2oPKbCAG5spKaAdYV5vAIcYYdG8d6uGMOaJ/2bZPGo=;
 b=ct7+EyJQrCu0r2n1l4e4Xn4XFD0gQcW0c2tIPVphdFyB8umFhz2JTY/ZtGzfLr6hCStfNi
 jBLWdJuXZJ/CXO+AqmUQE6KANuotuFPJINKhY/Gihfk4K8qoLKBSygxpe+z8dOFhG5/9RJ
 4koZCVrxUImzRRu0tM4eFJl9M4BQ63k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-YdpxNy9yPzOoPo1LHMAuKQ-1; Tue, 18 Aug 2026 05:51:54 -0400
X-MC-Unique: YdpxNy9yPzOoPo1LHMAuKQ-1
X-Mimecast-MFC-AGG-ID: YdpxNy9yPzOoPo1LHMAuKQ_1787046713
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so397478f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787046713; x=1787651513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+2oPKbCAG5spKaAdYV5vAIcYYdG8d6uGMOaJ/2bZPGo=;
 b=tzsb2kJQVVpcOx7ciJu++J5Wv766oIj6LIFBnilqOtzocbl2KE+hfzltczvYBI/BIX
 EjEjaf3b0rVl4/rLhvSAVmQ0YlL0BLWD3FFtXoxvTHvOuAAMlejh2HjedBnCkKoizE7Y
 cUyjkn7c52Qkmh2ldeWp4LkbNrkVua1Ji5sgE8pjH2FJ814AKPKOz3vqRvK27Opz56QP
 rn7EtEkBinM5sTq5uqIh5OG1mPfSlInVesFR/UpKWz2cPo0WI7WApWZCXxmQmo3VeOrW
 zKp6wTCRFbWnPMyRnaUbF6BwmQYpAqYKy9H+JdT7wDyJ8WU9PtuCi+vPIqPueFG12qHS
 XrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787046713; x=1787651513;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+2oPKbCAG5spKaAdYV5vAIcYYdG8d6uGMOaJ/2bZPGo=;
 b=cbas9sbSrDAxR2CGrRFaISU/tygdGscCFheh7ppR0Hbe92ig+q2sViCbxJTrtBpH0v
 sMNI5Fpa0tzaRJQed3ToN4+5gQRNKtw3GcY7ZTihkp8vvH35CPhS9zLNKf6gogCwsKZA
 OVAlIUqh84ZIazYuYe8tqiBsKdhyJ2pkFK+xeNRs3UhmgPBsvAky9B3uNVYXPxLUeU8a
 GhiLayGLqgw72CVJxewr/bOuhKx0xA/lMMMyK7KjH/GfXm/h08ax3352aheaEPbGO/l8
 spf5WziYiEnJ0zRh5lGl+NxasE527F2f5mm5DcvtbCyzdrAeW88wEb/c/+ffVWNnNmY3
 jnSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUPUrRNnS9efp/y3xJpvtRwsIzNgqtzhd97VikrDJRXTQqU8cJ1HoTzyyZ9Qr9n3XvhYuSfns/7Jyj@nongnu.org
X-Gm-Message-State: AOJu0Yw+DDTWAsIGGXFqg0x5tYTHfiIy/W1UaTAM9eL529cak9D3B7iD
 +p9N3Ac0VgYyGo5+EvCJx6qUghbJ3bNED0A0itwCyV0AvrNU1hOTBlulcAxoVA5xvPUyBjbokGi
 bTv7tZY3TFM41lYa9MjleLOAKUnwhKXILwZhmUnKE9ZPQIDj51n4Jl5jU
X-Gm-Gg: AR+sD12fz3HuX/zzIxeuRJ3u+IU/L+oPfx2+exL8Tfbaa38b56+gzi3kbifwkccBhEx
 7AE3hbIY1Dj21rfLJ/W7hfcmoAFSFQ6vDPV8/yhV0OV/u7rS8v8yhAs5dzN6Qo5B7JVwO84dUFg
 eWrdBFMhhggsLwYOYogDjkG3cXUrXc3BKkU7K9DoVbBkvRNMMIX4ssSr+fZh71KDfTUcd55gFKz
 yK5fEzaEoMZiKnVc35awZWwn6PQR7Mfi3r23CblS6wJ6vcZwsHLI0ZNXRd+WRsUaRd6MyalBW+3
 pCcJQVF4ZQq7socapXryWkBGStrFB3JTmlsxLRWqCWRMkBE5qimfWcACp8Zpcb5CdQ4qZrA=
X-Received: by 2002:a05:6000:430c:b0:47f:ec53:1d2d with SMTP id
 ffacd0b85a97d-482a9ea2e0cmr8034292f8f.7.1787046712919; 
 Tue, 18 Aug 2026 02:51:52 -0700 (PDT)
X-Received: by 2002:a05:6000:430c:b0:47f:ec53:1d2d with SMTP id
 ffacd0b85a97d-482a9ea2e0cmr8034223f8f.7.1787046712495; 
 Tue, 18 Aug 2026 02:51:52 -0700 (PDT)
Received: from [10.22.3.81] ([91.26.127.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7bc6esm11383973f8f.19.2026.08.18.02.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 02:51:51 -0700 (PDT)
Message-ID: <4dc41005-c819-43ca-8ba1-0907465c25a5@redhat.com>
Date: Tue, 18 Aug 2026 11:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: warn about hunks which only add blank lines
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>
References: <20260731134046.1015479-1-den@openvz.org>
 <299fa07a-9a40-4473-bfe7-38aab7248a79@virtuozzo.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <299fa07a-9a40-4473-bfe7-38aab7248a79@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On 18/08/2026 11.29, Denis V. Lunev wrote:
> On 7/31/26 15:40, Denis V. Lunev wrote:
>> This email originated from an IP that might not be authorized by the domain it was sent from.
>> Do not click links or open attachments unless it is an email you expected to receive.
>> Patches sometimes carry a hunk whose entire content is one or two
>> added blank lines. It changes nothing, it makes the diff longer and
>> it survives review because nobody looks twice at a blank line. The
>> blank line itself is perfectly fine, the gratuitous hunk is not.
>>
>> Tally the added blank lines and the other changes of every hunk in
>> the pre-scan loop which already walks the raw patch, and record the
>> hunks which only add blanks. Such a hunk is then reported at the
>> first blank line it adds, so the warning carries the usual file and
>> line context.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Chao Liu <chao.liu@processmission.com>
>> CC: "Daniel P. Berrange" <berrange@redhat.com>
>> CC: "Philippe Mathieu-Daude" <philmd@oss.qualcomm.com>
>> CC: Thomas Huth <thuth@redhat.com>
>> ---
>> Note: this patch is sent on behalf of the yesterday finding inside IDE
>>        pull request. This should be found with a checkpatch.
>>
>>   scripts/checkpatch.pl | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 03f35e7501..dfa9878006 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1567,6 +1567,10 @@ sub process {
>>   	my $first_line = 0;
>>   	my $p1_prefix = '';
>>   
>> +	my %blank_only_hunk;
>> +	my $hunk_first_blank = 0;
>> +	my $hunk_has_change = 0;
>> +
>>   	my $prev_values = 'E';
>>   
>>   	# suppression flags
>> @@ -1583,6 +1587,10 @@ sub process {
>>   		$line = $rawline;
>>   
>>   		if ($rawline=~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
>> +			$blank_only_hunk{$hunk_first_blank} = 1
>> +				if ($hunk_first_blank && !$hunk_has_change);
>> +			($hunk_first_blank, $hunk_has_change) = (0, 0);
>> +
>>   			$realline=$1-1;
>>   			if (defined $2) {
>>   				$realcnt=$3+1;
>> @@ -1633,6 +1641,13 @@ sub process {
>>   		push(@lines, $line);
>>   
>>   		if ($realcnt > 1) {
>> +			if ($rawline =~ /^\+\s*$/) {
>> +				$hunk_first_blank = $linenr
>> +					if (!$hunk_first_blank);
>> +			} elsif ($rawline =~ /^[-+]/) {
>> +				$hunk_has_change = 1;
>> +			}
>> +
>>   			$realcnt-- if ($line =~ /^(?:\+| |$)/);
>>   		} else {
>>   			$realcnt = 0;
>> @@ -1641,6 +1656,8 @@ sub process {
>>   		#print "==>$rawline\n";
>>   		#print "-->$line\n";
>>   	}
>> +	$blank_only_hunk{$hunk_first_blank} = 1
>> +		if ($hunk_first_blank && !$hunk_has_change);
>>   
>>   	$prefix = '';
>>   
>> @@ -1780,6 +1797,10 @@ sub process {
>>   
>>   		$cnt_lines++ if ($realcnt != 0);
>>   
>> +		if ($blank_only_hunk{$linenr}) {
>> +			WARN("this hunk only adds blank lines\n" . $herecurr);
>> +		}
>> +
>>   # Only allow Python 3 interpreter
>>   		if ($realline == 1 &&
>>   			$line =~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {
>>
>> base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
> Guys,
> 
> does it make sense to continue discussion or this patch
> goes to /dev/null as nobody is interested in?
  Hi,

sorry, but I still don't have a proper clue whether this is really a good 
idea or not. There could also be valid cases where a hunk that adds a single 
blank line could be fine ... so I'd tend to rather not add this patch? What 
do others think?

  Thomas


